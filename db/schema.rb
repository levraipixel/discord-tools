# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_17_162847) do

  create_table "channels", force: :cascade do |t|
    t.string "discord_id"
    t.integer "guild_id"
    t.integer "parent_id"
    t.string "name"
    t.integer "position"
    t.string "topic"
    t.boolean "is_imported"
    t.index ["discord_id"], name: "index_channels_on_discord_id", unique: true
    t.index ["guild_id"], name: "index_channels_on_guild_id"
    t.index ["parent_id"], name: "index_channels_on_parent_id"
    t.index ["position"], name: "index_channels_on_position"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
  end

  create_table "characters_players", force: :cascade do |t|
    t.integer "character_id"
    t.integer "player_id"
    t.index ["character_id"], name: "index_characters_players_on_character_id"
    t.index ["player_id"], name: "index_characters_players_on_player_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "icon"
    t.string "name"
  end

  create_table "guilds", force: :cascade do |t|
    t.string "discord_id"
    t.string "name"
    t.index ["discord_id"], name: "index_guilds_on_discord_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.string "discord_id"
    t.integer "channel_id"
    t.string "author"
    t.text "content"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["discord_id"], name: "index_messages_on_discord_id", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.integer "city_id"
    t.integer "team_id"
    t.string "name"
    t.index ["city_id"], name: "index_players_on_city_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "avatar_url"
    t.string "name"
    t.string "discord_username"
    t.string "discord_discriminator"
    t.string "discord_token"
    t.string "discord_refresh_token"
    t.boolean "discord_token_expires"
    t.integer "discord_token_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
