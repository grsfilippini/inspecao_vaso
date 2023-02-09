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

ActiveRecord::Schema.define(version: 2023_02_08_180555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cadastros", force: :cascade do |t|
    t.bigint "corp_id", default: 1
    t.bigint "cidade_id"
    t.bigint "regiao_id", default: 1
    t.string "nome", null: false
    t.string "nome_curto", null: false
    t.string "cnpj", null: false
    t.string "logradouro"
    t.string "numero"
    t.string "bairro"
    t.string "cep"
    t.string "email"
    t.string "fone"
    t.string "contato"
    t.string "website"
    t.string "observacoes"
    t.boolean "eh_fabricante", default: false
    t.boolean "eh_empresa_inspetora", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_cadastros_on_cidade_id"
    t.index ["corp_id"], name: "index_cadastros_on_corp_id"
    t.index ["regiao_id"], name: "index_cadastros_on_regiao_id"
  end

  create_table "cidades", force: :cascade do |t|
    t.string "nome", null: false
    t.bigint "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id"
  end

  create_table "corps", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string "nome", null: false
    t.string "uf", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regiaos", force: :cascade do |t|
    t.bigint "corp_id"
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corp_id"], name: "index_regiaos_on_corp_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cadastros", "cidades"
  add_foreign_key "cadastros", "corps"
  add_foreign_key "cadastros", "regiaos"
  add_foreign_key "cidades", "estados"
  add_foreign_key "regiaos", "corps"
end
