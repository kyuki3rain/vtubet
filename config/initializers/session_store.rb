if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
else
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
end
Rails.application.config.api_only = false