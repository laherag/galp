class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string   :apellido
      t.string   :nombre
      t.string   :galp_status
      t.string   :tipo
      t.string   :confort
      t.string   :marca_caldera
      t.boolean  :facturacion_electronica, default: true
      t.string   :municipio
      t.string   :provincia
      t.string   :telefono_1
      t.string   :telefono_2
      t.string   :titular_final
      t.string   :dni_titular_final
      t.string   :representante
      t.string   :dni_representante
      t.string   :numero_de_cuenta
      t.string   :email
      t.boolean  :lopd_robinson
      t.text     :observaciones
      t.string   :direccion
      t.string   :cig
      t.string   :moving_type
      t.string   :state
      t.integer  :teleop_id
      t.string   :zip_code
      t.date     :fecha_venta
      t.timestamps
    end
  end
end
