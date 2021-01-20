if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_vtubet', domain: :all
else
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
end