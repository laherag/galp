class CreateGazContracts < ActiveRecord::Migration
  def change
    create_table :gaz_contracts do |t|
      t.integer :contract_id
      t.string  :nombre_antiguo_titular_gas
      t.string  :apellido_antiguo_titular_gas
      t.boolean :cambio_de_titular
      t.string  :dni_gaz
      t.string  :cups_gaz
      t.text    :direccion_gaz
      t.string  :contador_gaz
      t.string  :tipo_gaz
    end
  end
end
