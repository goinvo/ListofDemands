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

ActiveRecord::Schema.define(version: 2018_07_11_004515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "area_definitions", force: :cascade do |t|
    t.integer "municipality_id"
    t.bigint "zip_code_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "county_id"
    t.integer "state_id"
    t.integer "country_id"
    t.index ["municipality_id", "zip_code_id"], name: "index_area_definitions_on_municipality_id_and_zip_code_id", unique: true
    t.index ["municipality_id"], name: "index_area_definitions_on_municipality_id"
    t.index ["zip_code_id"], name: "index_area_definitions_on_zip_code_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "type"
    t.string "short_name"
    t.index ["name"], name: "index_areas_on_name", unique: true
  end

  create_table "demand_relationships", force: :cascade do |t|
    t.bigint "demand_id"
    t.bigint "related_demand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demand_id", "related_demand_id"], name: "index_demand_relationships_on_demand_id_and_related_demand_id", unique: true
    t.index ["demand_id"], name: "index_demand_relationships_on_demand_id"
    t.index ["related_demand_id"], name: "index_demand_relationships_on_related_demand_id"
  end

  create_table "demands", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "solution"
    t.integer "problem_id", null: false
    t.string "topic"
    t.index ["area_id"], name: "index_demands_on_area_id"
    t.index ["user_id"], name: "index_demands_on_user_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "problems", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "address1", null: false
    t.string "address2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "gender"
    t.date "date_of_birth"
    t.string "political_party"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "private_user", default: false
    t.string "username"
    t.index "lower((username)::text)", name: "index_profiles_on_lower_username", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_demands", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "demand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", null: false
    t.index ["demand_id", "user_id"], name: "index_user_demands_on_demand_id_and_user_id", unique: true
    t.index ["demand_id"], name: "index_user_demands_on_demand_id"
    t.index ["user_id"], name: "index_user_demands_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string "zip", null: false
    t.string "city"
    t.string "state"
    t.string "state_abbreviation"
    t.string "county"
    t.decimal "latitude", precision: 7, scale: 4
    t.decimal "longitude", precision: 7, scale: 4
    t.index ["zip"], name: "index_zip_codes_on_zip", unique: true
  end

  add_foreign_key "demand_relationships", "demands"
  add_foreign_key "demand_relationships", "demands", column: "related_demand_id"

  create_view "search_demands", materialized: true,  sql_definition: <<-SQL
      SELECT d.id AS demand_id,
      d.user_id AS created_by_user_id,
      ( SELECT area_definitions.municipality_id
             FROM ((area_definitions
               JOIN areas areas_1 ON ((areas_1.id = area_definitions.municipality_id)))
               JOIN demands ON ((areas_1.id = demands.area_id)))
            WHERE (demands.id = d.id)
           LIMIT 1) AS municipality_id,
      ( SELECT area_definitions.state_id
             FROM ((area_definitions
               JOIN areas areas_1 ON ((areas_1.id = area_definitions.state_id)))
               JOIN demands ON ((areas_1.id = demands.area_id)))
            WHERE (demands.id = d.id)
           LIMIT 1) AS state_id,
      ( SELECT area_definitions.country_id
             FROM ((area_definitions
               JOIN areas areas_1 ON ((areas_1.id = area_definitions.country_id)))
               JOIN demands ON ((areas_1.id = demands.area_id)))
            WHERE (demands.id = d.id)
           LIMIT 1) AS country_id,
      problems.name AS problem,
      d.solution,
      d.topic,
      ( SELECT count(user_demands.id) AS count
             FROM user_demands
            WHERE (user_demands.demand_id = d.id)) AS demand_count,
      d.created_at
     FROM ((demands d
       JOIN problems ON ((problems.id = d.problem_id)))
       LEFT JOIN areas ON ((areas.id = d.area_id)));
  SQL

end
