require 'reform/rails'

class ContractForm < Reform::Form
  include Reform::Form::ActiveRecord
  
  model :contract

  properties %i[
    apellido
    direccion dni_representante dni_titular_final
    email
    confort
    lopd_robinson
    marca_caldera municipio
    nombre numero_de_cuenta
    observaciones
    provincia
    representante
    telefono_1 telefono_2 teleop_id tipo titular_final
    zip_code
  ]

  validates :nombre, presence: true
  validates :dni_titular_final, presence: true
  validates :dni_titular_final, dni: true
  validates :telefono_1, presence: true
  validates :direccion, presence: true
  validates :municipio, presence: true
  validates :provincia, presence: true
  validates :numero_de_cuenta, presence: true

  property :gaz_contract, form: GazContractForm
  property :luz_contract, form: LuzContractForm

  #--------------------------------------------------------------------------------
  def self.enumerized_attributes
    Contract.enumerized_attributes
  end
  
  #--------------------------------------------------------------------------------
  alias_method :super_save, :save
  def save
    super
  end
  
  #--------------------------------------------------------------------------------
  def save(user, completed)
    super_save()
    
    contract = self.model

    # completed state
    contract.mark_as_completed(completed)

    # no updated_at change
    contract.update(updated_at: contract.created_at)

    # set teleop
    contract.update(teleop_id: user.id)

    # setup moving_type
    set_moving_type(contract)

    contract
  end

  #--------------------------------------------------------------------------------    
  def set_moving_type(contract)
    gaz_moving_type = moving_type(contract.gaz_contract.tipo_gas)
    luz_moving_type = moving_type(contract.luz_contract.tipo_luz)

    types = [gaz_moving_type, luz_moving_type].uniq.compact
    
    moving_type = if gaz_moving_type == :cambio and luz_moving_type == :alta
      :alta
    elsif types.count == 2 
      :alta_y_cambio
    else
      types.first
    end

    contract.update(moving_type: moving_type)
  end

  #--------------------------------------------------------------------------------    
  def moving_type(tipo_gas_lus)
    if tipo_gas_lus == "cambio_de_comercializadora"
      :cambio
    elsif tipo_gas_lus 
      :alta
    else
      nil
    end
  end
end