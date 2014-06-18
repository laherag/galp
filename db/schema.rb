# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140618143800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: true do |t|
    t.string   "apellido"
    t.string   "nombre"
    t.string   "galp_status"
    t.string   "tipo"
    t.string   "confort"
    t.string   "marca_caldera"
    t.boolean  "facturacion_electronica", default: true
    t.string   "municipio"
    t.string   "provincia"
    t.string   "telefono_1"
    t.string   "telefono_2"
    t.string   "titular_final"
    t.string   "dni_titular_final"
    t.string   "representante"
    t.string   "dni_representante"
    t.string   "numero_de_cuenta"
    t.string   "email"
    t.boolean  "lopd_robinson"
    t.text     "observaciones"
    t.string   "direccion"
    t.string   "cig"
    t.string   "moving_type"
    t.string   "state"
    t.integer  "teleop_id"
    t.string   "zip_code"
    t.date     "fecha_venta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
