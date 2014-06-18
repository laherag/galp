class LuzContractForm < Reform::Form
  include Reform::Form::ActiveRecord

  properties %i[
    nombre_antiguo_titular_luz
    apellido_antiguo_titular_luz
    cambio_de_titular
    dni_luz
    cups_luz
    contador_luz
    tarifa_luz
    tipo_luz
    tipo_potencia
    potencia_deseada_luz
    cambio_potencia
    certificado
    codigo_cie
    codigo_instalador_cie
    nombre_razon_del_instalador
    potencia_de_la_instalacion
    fecha_inicio_validez_cie
    fecha_caducidad_cie
    tension_suministro
  ]

  validates :cups_luz, cups: true
  
  def self.enumerized_attributes
    LuzContract.enumerized_attributes
  end
end