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

ActiveRecord::Schema.define(version: 20140418042915) do

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  create_table "journeys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "title"
    t.integer  "value_proposition_id"
  end

  add_index "journeys", ["value_proposition_id"], name: "index_journeys_on_value_proposition_id"

  create_table "resource_formats", force: true do |t|
    t.integer  "format_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "full_description"
    t.integer  "user_id"
    t.string   "source"
    t.string   "tag_list"
    t.string   "image"
    t.string   "default_image"
    t.string   "file"
    t.integer  "position"
  end

  create_table "step_resources", force: true do |t|
    t.integer  "step_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "step_resources", ["resource_id"], name: "index_step_resources_on_resource_id"
  add_index "step_resources", ["step_id"], name: "index_step_resources_on_step_id"

  create_table "steps", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_proposition_id"
    t.integer  "position"
    t.integer  "journey_id"
  end

  add_index "steps", ["journey_id"], name: "index_steps_on_journey_id"

  create_table "suggestions", force: true do |t|
    t.string   "author"
    t.text     "thoughts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["resource_id"], name: "index_taggings_on_resource_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traits", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_trait_description"
    t.integer  "spectrum_id"
    t.string   "image"
  end

  create_table "upvotes", force: true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",        default: false
  end

  create_table "value_proposition_associations", force: true do |t|
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_proposition_id"
  end

  create_table "value_proposition_categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "value_propositions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_proposition_category_id"
    t.string   "default_image"
  end

end
