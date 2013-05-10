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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130510164750) do

  create_table "comments", :force => true do |t|
    t.text     "comment",    :limit => 2147483647
    t.integer  "task_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "is_active"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "auth_token"
    t.boolean  "is_system_admin"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_id"
  end

  create_table "project_roles", :force => true do |t|
    t.integer  "person_id"
    t.integer  "project_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description", :limit => 2147483647
    t.integer  "createdby"
    t.integer  "updatedby"
    t.boolean  "is_active"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_statusesss", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description",    :limit => 2147483647
    t.integer  "project_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "assigned_to"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "is_active"
    t.date     "due_date"
    t.integer  "task_status_id"
    t.integer  "task_number"
    t.date     "date_completed"
  end

end
