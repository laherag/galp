class GazContract < ActiveRecord::Base
  extend Enumerize
  
  belongs_to :contract

  enumerize :tipo_gas, in: [:cambio_de_comercializadora,
                            :ad_segunda_ocup, 
                            :ad_nuevo_suministro
                            ], scope: true
  
  enumerize :tarifa_gas, in: %w[3.1 3.2]

  enumerize :contador_gas, in: [:alquiler, :propiedad]

  def to_csv
    [
      tipo_gas,
      nombre_antiguo_titular_gas,
      apellido_antiguo_titular_gas,
      dni_gas,
      cups_gas,
      tarifa_gas,
      direccion_csv(),
      zip_code_csv(),
      contador_gas
    ]
  end

  def direccion_csv
    contract.gaz_contract? ? contract.direccion : ''
  end

  def zip_code_csv
    contract.gaz_contract? ? contract.zip_code : ''
  end

end
