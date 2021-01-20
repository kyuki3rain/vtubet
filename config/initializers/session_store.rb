if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_vtubet', domain: 'kyuki3rain.com'
else
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
end