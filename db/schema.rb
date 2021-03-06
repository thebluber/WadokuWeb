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

ActiveRecord::Schema.define(:version => 20110515161642) do

  create_table "entries", :force => true do |t|
    t.integer  "wadoku_id"
    t.string   "romaji"
    t.string   "writing"
    t.string   "kana"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entry_relation"
    t.string   "midashigo"
    t.text     "parsed"
  end

  add_index "entries", ["entry_relation"], :name => "index_entries_on_entry_relation"
  add_index "entries", ["romaji", "writing", "kana"], :name => "index_entries_on_romaji_and_writing_and_kana"

  create_table "ex_sentences", :force => true do |t|
    t.integer  "tatoeba_id"
    t.string   "lang"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "word"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keywords", ["word"], :name => "index_keywords_on_word"

  create_table "translation_equivalents", :id => false, :force => true do |t|
    t.integer "ex_sentence_id"
    t.integer "translation_id"
  end

end
