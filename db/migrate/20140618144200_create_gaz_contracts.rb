class CreateGazContracts < ActiveRecord::Migration
  def change
    create_table :gaz_contracts do |t|
      t.integer :contract_id
      t.string  :nombre_antiguo_titular_gas
      t.string  :apellido_antiguo_titular_gas
      t.boolean :cambio_de_titular
      t.string  :dni_gas
      t.string  :cups_gas
      t.string  :contador_gas
      t.string  :tipo_gas
      t.string  :tarifa_gas
    end
  end
end
