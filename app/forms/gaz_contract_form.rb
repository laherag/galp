class GazContractForm < Reform::Form
  include Reform::Form::ActiveRecord

  properties %i[
    nombre_antiguo_titular_gas
    apellido_antiguo_titular_gas
    dni_gas
    cups_gas
    contador_gas
    tarifa_gas
    tipo_gas
  ]

  property :cambio_de_titular
  
  validates :cups_gas, cups: true
  
  def self.enumerized_attributes
    GazContract.enumerized_attributes
  end
end
