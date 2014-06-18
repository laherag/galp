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

ActiveRecord::Schema.define(version: 20140527090600) do

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "direccion"
    t.string   "cig"
    t.string   "moving_type"
    t.string   "state"
    t.integer  "teleop_id"
    t.string   "zip_code"
    t.date     "fecha_venta"
  end

  create_table "gaz_contracts", force: true do |t|
    t.integer "contract_id"
    t.string  "nombre_antiguo_titular_gas"
    t.string  "apellido_antiguo_titular_gas"
    t.boolean "cambio_de_titular"
    t.string  "dni_gas"
    t.string  "cups_gas"
    t.string  "contador_gas"
    t.string  "tipo_gas"
    t.string  "tarifa_gas"
  end

  create_table "luz_contracts", force: true do |t|
    t.integer "contract_id"
    t.string  "nombre_antiguo_titular_luz"
    t.string  "apellido_antiguo_titular_luz"
    t.boolean "cambio_de_titular"
    t.string  "dni_luz"
    t.string  "cups_luz"
    t.string  "contador_luz"
    t.string  "tipo_luz"
    t.string  "potencia_deseada_luz"
    t.boolean "certificado"
    t.string  "codigo_cie"
    t.string  "codigo_instalador_cie"
    t.string  "nombre_razon_del_instalador"
    t.string  "potencia_de_la_instalacion"
    t.date    "fecha_inicio_validez_cie"
    t.date    "fecha_caducidad_cie"
    t.string  "tension_suministro"
    t.string  "tarifa_luz"
    t.boolean "cambio_potencia"
    t.string  "tipo_potencia"
  end

  create_table "records", force: true do |t|
    t.string   "file"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_stats", force: true do |t|
    t.integer  "user_id"
    t.integer  "nb_contracts", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.boolean  "teleop",                 default: false
    t.boolean  "galp",                   default: false
    t.string   "firstname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
