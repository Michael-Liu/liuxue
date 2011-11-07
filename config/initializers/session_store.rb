# Be sure to restart your server when you modify this file.

Liuxue::Application.config.session_store :cookie_store, :key => '_liuxue_session'
# Liuxue::Application.config.session_store :redis_session_store, :servers => $_app_cache.server

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Liuxue::Application.config.session_store :active_record_store
