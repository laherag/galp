class CreateLuzContracts < ActiveRecord::Migration
  def change
    create_table :luz_contracts do |t|
      t.integer :contract_id
      t.string  :nombre_antiguo_titular_luz
      t.string  :apellido_antiguo_titular_luz
      t.boolean :cambio_de_titular
      t.string  :dni_luz
      t.string  :cups_luz
      t.string  :contador_luz
      t.string  :tipo_luz
      t.string  :potencia_deseada_luz
      t.boolean :certificado
      t.string  :codigo_cie
      t.string  :codigo_instalador_cie
      t.string  :nombre_razon_del_instalador
      t.string  :potencia_de_la_instalacion
      t.date    :fecha_inicio_validez_cie
      t.date    :fecha_caducidad_cie
      t.string  :tension_suministro
      t.string  :tarifa_luz
      t.boolean :cambio_potencia
      t.string  :tipo_potencia
    end
  end
end
