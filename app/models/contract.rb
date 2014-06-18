class Contract < ActiveRecord::Base
  extend Enumerize

  SELECTRA_PREFIX = "G15"

  has_one :gaz_contract
  has_one :luz_contract
  belongs_to :teleop, class_name: "User"

  enumerize :confort, in: %i[no
                             confort_gas
                             confort_clima
                             confort_hogar
                             ], default: :no

  enumerize :tipo, in: %i[gas_y_luz gas]

  enumerize :galp_status, in: %i[cargado 
                                cargado_fe
                                devuelto
                                no_posible_carga
                                rechazado
                                ya_gestionado
                                enviado_galp]

  enumerize :moving_type, in: %i[alta cambio alta_y_cambio]

  enumerize :state, in: %i[completed uncompleted csv_ready], default: :uncompleted

  scope :sorted, order(id: :desc)

  scope :with_moving_type, -> (*types) { where(moving_type: [types]) }
  scope :with_state, -> (*states) { where(state: [states]) }

  scope :without_galp_status, -> { where(galp_status: nil) }

  scope :belongs_to, ->(user_id) { where(teleop_id: user_id) }
  scope :created_at, ->(day) {
    where('created_at > ? AND created_at < ?', 
      day.beginning_of_day, day.end_of_day)
  }

  def mark_as_completed(completed = true)
    unless state == 'csv_ready'
      if completed
        update(state: "completed")
      else
        update(state: "uncompleted")
      end
    end
  end

  def no_confort?
    confort == Contract.confort.find_value(:no)
  end

  def gaz_contract?
    tipo == 'gas' or tipo == 'gas_y_luz'
  end

  def luz_contract?
    tipo == 'luz' or tipo == 'gas_y_luz'
  end

  def gaz_y_luz_contract?
    tipo == 'gas_y_luz'
  end

  def generate_cig(user)
    date = Date.today.strftime "%Y%m%d"
    nb_contract = user.stats.today.nb_contracts
    nb_contract = nb_contract.to_s.rjust(4, '0')

    user_id = user.id.to_s.rjust(2, '0')

    cig_id = "#{user_id}#{nb_contract}"

    "#{date}#{Contract::SELECTRA_PREFIX}#{cig_id}"
  end

  #--------------------------------------------------------------------------------
  # CSV GENERATION
  #--------------------------------------------------------------------------------

  def to_csv
    attributes = ordered_attributes()
    
    attributes.map do |attribute|
      if is_boolean(attribute)
        to_es_bool(attribute)
      elsif attribute.respond_to?(:upcase)
        attribute.upcase
      else
        attribute
      end 
    end
  end

  def ordered_attributes
    [
      provincia,
      'S',
      '', # fecha subidad, empty for now
      DateUtil.format_date(fecha_venta),
      gaz_y_luz_contract? || gaz_contract?,
      gaz_y_luz_contract? || luz_contract?,
      confort,
      facturacion_electronica,
      marca_caldera,
      plan_contratado()
    ]
    .concat(gaz_contract.to_csv)
    .concat(luz_contract.to_csv)
    .concat [
      municipio,
      provincia,
      telefono_1,
      telefono_2,
      titular_final(),
      numero_de_cuenta,
      email,
      robinson(),
      cig,
      misc()
    ]
  end

  def plan_contratado
    res = 'FÓRM. '
    
    res += case tipo
    when 'gas' then 'Gas'
    when 'luz' then 'Luz'
    else 
      'Gas+Luz'
    end

    res += '+Confort' if confort_csv?()
    res += '+FE' if facturacion_electronica
    res
  end

  def robinson
    if lopd_robinson
      'ROBINSON'
    else
      'NO ROBINSON'
    end
  end

  def to_es_bool(condition)
    condition ? 'SI' : 'NO'
  end

  def is_boolean(param)
    !! param == param
  end

  # sorry for that but it is not my fault this time 
  def cambio_de_potencia?
    observaciones and observaciones.downcase.include?('cambio de potencia')
  end

  def misc
    res = []
    res << if gaz_contract.cambio_de_titular
      "Cambio de titular gas"
    end

    res << if luz_contract.cambio_de_titular
      "Cambio de titular luz"
    end

    res << 'cambio de potencia' if cambio_de_potencia?
    
    res << if representante.present?
      "representante: #{representante}"
    end

    res << dni_representante
    res << luz_contract.tipo_potencia.try { |tp| "TIPO POTENCIA: #{tp}" }
    res << observaciones

    res.reject! { |e| e.nil? or e.empty? }.join(' . ')
  end

  def titular_final
    [nombre, apellido, dni_titular_final].join(' ')
  end

  def confort_csv?
    confort 
  end

end