if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_vtubet', domain: :all, same_site: :none
else
  Rails.application.config.session_store :cookie_store, key: '_vtubet'
end