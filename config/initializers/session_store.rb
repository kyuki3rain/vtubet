if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_vtubet', domain: 'vigilant-jones-9c8528.netlify.app'
else
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
end