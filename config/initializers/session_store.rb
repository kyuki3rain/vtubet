if Rails.env === 'production'
  Rails.application.config.session_store :cache_store, key: '_vtubet', same_site: :none
else
  Rails.application.config.session_store :cache_store, key: '_vtubet'
end