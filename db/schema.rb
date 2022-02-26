# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_22_123150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_function :f_unaccent, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.f_unaccent(text)
       RETURNS text
       LANGUAGE sql
       IMMUTABLE
      AS $function$
      SELECT public.unaccent('public.unaccent', $1)  -- schema-qualify function and dictionary
      $function$
  SQL

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "resource_id"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bans", force: :cascade do |t|
    t.string "telegram_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ban_reason"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "notification_message"
    t.datetime "banned_until"
    t.json "user_attributes", default: {}
    t.uuid "user_id"
    t.index ["telegram_id"], name: "index_bans_on_telegram_id"
  end

  create_table "changelogs", force: :cascade do |t|
    t.uuid "uuid"
    t.text "body", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_changelogs_on_uuid"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.uuid "sender_id"
    t.uuid "recipient_id"
    t.uuid "match_kind_id"
    t.datetime "accepted_at"
    t.boolean "is_sender_unread", default: false
    t.boolean "is_recipient_unread", default: true
    t.uuid "preview_message_id"
    t.index ["match_kind_id"], name: "index_chats_on_match_kind_id"
    t.index ["recipient_id"], name: "index_chats_on_recipient_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
    t.index ["uuid"], name: "index_chats_on_uuid", unique: true
  end

  create_table "errors", force: :cascade do |t|
    t.jsonb "backtrace"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "exception"
  end

  create_table "event_categories", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "system", default: false
  end

  create_table "event_users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.uuid "user_id"
    t.uuid "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.text "description"
    t.string "privacy_status"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.uuid "user_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "maximum_searchable_distance"
    t.string "localities", array: true
    t.uuid "event_category_id"
    t.integer "users_count", default: 0, null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "order", default: 0
    t.index ["uuid"], name: "index_genders_on_uuid", unique: true
  end

  create_table "genders_users", force: :cascade do |t|
    t.uuid "gender_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.index ["gender_id"], name: "index_genders_users_on_gender_id"
    t.index ["user_id"], name: "index_genders_users_on_user_id"
    t.index ["uuid"], name: "index_genders_users_on_uuid", unique: true
  end

  create_table "geometries", force: :cascade do |t|
    t.string "reference"
    t.json "properties"
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.geometry "geom", limit: {:srid=>4326, :type=>"multi_polygon"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cached_name"
    t.jsonb "cached_hierarchy", default: {}
    t.index "to_tsvector('english'::regconfig, cached_hierarchy)", name: "index_geometries_on_cached_hierarchy", using: :gist
    t.index ["geom"], name: "index_geometries_on_geom", using: :gist
    t.index ["lonlat"], name: "index_geometries_on_lonlat", using: :gist
    t.index ["reference"], name: "index_geometries_on_reference"
  end

  create_table "group_categories", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0
    t.index ["uuid"], name: "index_group_categories_on_uuid", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0, null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.uuid "group_category_id"
    t.index ["uuid"], name: "index_groups_on_uuid", unique: true
  end

  create_table "groups_users", force: :cascade do |t|
    t.uuid "group_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
    t.index ["uuid"], name: "index_groups_users_on_uuid", unique: true
  end

  create_table "information_items", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "type"
    t.string "title"
    t.text "body"
    t.integer "order", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.uuid "liker_id", null: false
    t.uuid "liked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liked_id"], name: "index_likes_on_liked_id"
    t.index ["liker_id"], name: "index_likes_on_liker_id"
    t.index ["uuid"], name: "index_likes_on_uuid"
  end

  create_table "match_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "order", default: 0
    t.index ["uuid"], name: "index_match_kinds_on_uuid", unique: true
  end

  create_table "match_kinds_users", force: :cascade do |t|
    t.uuid "uuid"
    t.uuid "user_id"
    t.uuid "match_kind_id"
    t.index ["match_kind_id"], name: "index_match_kinds_users_on_match_kind_id"
    t.index ["user_id"], name: "index_match_kinds_users_on_user_id"
    t.index ["uuid"], name: "index_match_kinds_users_on_uuid", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.uuid "chat_id"
    t.uuid "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "body_ciphertext"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
    t.index ["uuid"], name: "index_messages_on_uuid", unique: true
  end

  create_table "pictures", force: :cascade do |t|
    t.string "picture"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.index ["user_id"], name: "index_pictures_on_user_id"
    t.index ["uuid"], name: "index_pictures_on_uuid", unique: true
  end

  create_table "profile_field_groups", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.integer "order", default: 0
    t.index ["uuid"], name: "index_profile_field_groups_on_uuid", unique: true
  end

  create_table "profile_fields", force: :cascade do |t|
    t.uuid "profile_field_group_id"
    t.string "name"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "pattern"
    t.string "regexp"
    t.string "validation"
    t.string "deep_link_pattern"
    t.string "app_store_id"
    t.string "play_store_id"
    t.string "description"
    t.boolean "restricted", default: false
    t.index ["profile_field_group_id"], name: "index_profile_fields_on_profile_field_group_id"
    t.index ["uuid"], name: "index_profile_fields_on_uuid", unique: true
  end

  create_table "relationship_statuses", force: :cascade do |t|
    t.integer "order", default: 0
    t.string "name"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
  end

  create_table "reports", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.text "description"
    t.uuid "reporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "new"
    t.uuid "subject_id"
    t.string "subject_type"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "expo_token"
    t.integer "version"
    t.string "device"
    t.string "code"
    t.datetime "code_expiration_date"
    t.string "ip"
    t.datetime "last_seen_at"
    t.index ["user_id"], name: "index_sessions_on_user_id"
    t.index ["uuid"], name: "index_sessions_on_uuid", unique: true
  end

  create_table "sexual_orientations", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "name"
    t.string "label"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_sexual_orientations_on_uuid"
  end

  create_table "sexual_orientations_users", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "sexual_orientation_id", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.index ["sexual_orientation_id"], name: "index_sexual_orientations_users_on_sexual_orientation_id"
    t.index ["user_id"], name: "index_sexual_orientations_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "telegram_username"
    t.text "bio"
    t.datetime "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "telegram_id", default: "", null: false
    t.string "distance_unit", default: "kilometers"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.hstore "profile_field_values", default: {}, null: false
    t.string "blocked_users_ids", default: [], array: true
    t.string "match_kind_ids_cache", default: [], array: true
    t.string "gender_ids_cache", default: [], array: true
    t.string "group_ids_cache", default: [], array: true
    t.string "state", default: "hidden"
    t.uuid "relationship_status_id"
    t.string "liked_ids_cache", default: [], array: true
    t.integer "likers_count", default: 0, null: false
    t.boolean "allow_chat_notification", default: true
    t.boolean "allow_message_notification", default: true
    t.boolean "allow_like_notification", default: true
    t.datetime "last_seen_at"
    t.integer "age_cache"
    t.boolean "share_online_status", default: true
    t.boolean "hide_birthdate", default: false
    t.boolean "system", default: false
    t.string "localities", default: [], array: true
    t.text "like"
    t.text "dislike"
    t.string "sexual_orientation_ids_cache", default: [], array: true
    t.boolean "hide_not_common_groups", default: false
    t.boolean "hide_city", default: false
    t.string "liker_ids_cache", default: [], array: true
    t.float "maximum_searchable_distance"
    t.boolean "hide_likes", default: false
    t.tsvector "tsvector"
    t.datetime "location_changed_at"
    t.boolean "allow_event_created_notification", default: true
    t.boolean "allow_event_joined_notification", default: true
    t.string "restricted_profile_fields", default: [], array: true
    t.string "events_as_participant_ids_cache", default: [], array: true
    t.float "karma", default: 0.0
    t.float "karma_boost", default: 0.0
    t.index "f_unaccent((name)::text) gin_trgm_ops", name: "users_name", using: :gin
    t.index ["blocked_users_ids"], name: "index_users_on_blocked_users_ids", using: :gin
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["events_as_participant_ids_cache"], name: "index_users_on_events_as_participant_ids_cache", using: :gin
    t.index ["gender_ids_cache"], name: "index_users_on_gender_ids_cache", using: :gin
    t.index ["group_ids_cache"], name: "index_users_on_group_ids_cache", using: :gin
    t.index ["karma"], name: "index_users_on_karma"
    t.index ["last_seen_at"], name: "index_users_on_last_seen_at"
    t.index ["liked_ids_cache"], name: "index_users_on_liked_ids_cache", using: :gin
    t.index ["liker_ids_cache"], name: "index_users_on_liker_ids_cache", using: :gin
    t.index ["localities"], name: "index_users_on_localities", using: :gin
    t.index ["lonlat"], name: "index_users_on_lonlat", using: :gist
    t.index ["match_kind_ids_cache"], name: "index_users_on_match_kind_ids_cache", using: :gin
    t.index ["profile_field_values"], name: "index_users_on_profile_field_values", using: :gin
    t.index ["sexual_orientation_ids_cache"], name: "index_users_on_sexual_orientation_ids_cache", using: :gin
    t.index ["state"], name: "index_users_on_state"
    t.index ["telegram_id"], name: "index_users_on_telegram_id", unique: true
    t.index ["tsvector"], name: "index_users_on_tsvector", using: :gin
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end


  create_trigger :update_tsvector, sql_definition: <<-SQL
      CREATE TRIGGER update_tsvector BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('tsvector', 'pg_catalog.english', 'like', 'bio')
  SQL
end
