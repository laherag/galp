class LuzContract < ActiveRecord::Base
  extend Enumerize
  
  belongs_to :contract

  enumerize :tipo_luz, in: [:ad_nuevo_suministro,
                            :ad_segunda_ocup, 
                            :cambio_de_comercializadora
                            ]

  enumerize :contador_luz, in: [:alquiler, :propiedad]

  enumerize :tension_suministro, in: [:trifásico, :monofásico]

  enumerize :tarifa_luz, in: %w[2.0A 2.1A]

  enumerize :tipo_potencia, in: %w[bajada_de_potencia aumento_de_potencia]

  def to_csv
    [
      tipo_luz,
      nombre_antiguo_titular_luz,
      apellido_antiguo_titular_luz,
      dni_luz,
      cups_luz_csv(),
      tarifa_luz,
      potencia_deseada_luz,
      codigo_cie,
      codigo_instalador_cie,
      nombre_razon_del_instalador,
      potencia_de_la_instalacion,
      DateUtil.format_date(fecha_inicio_validez_cie),
      DateUtil.format_date(fecha_caducidad_cie),
      tension_suministro,
      direccion_csv(),
      zip_code(),      
      contador_luz
    ]
  end

  def direccion_csv
    contract.luz_contract? ? contract.direccion : ''
  end

  def zip_code
    contract.luz_contract? ? contract.zip_code : ''
  end

  def cups_luz_csv
    if contract.luz_contract?
      case cups_luz[0..5]
      when 'ES0031', 'ES0026', 'ES0027', 'ES0033'
        cups_luz[0..19] + '0F'
      when 'ES0022'
        cups_luz[0..19] + '1P'
      when 'ES0021'
        cups_luz[0..19]
      else
        cups_luz
      end
    end
  end

end
