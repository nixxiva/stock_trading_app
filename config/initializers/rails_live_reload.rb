RailsLiveReload.configure do |config|
  config.watch %r{app/views/.*}, reload: :always
  config.watch %r{app/controllers/.*}, reload: :always
  config.watch %r{app/assets/stylesheets/.*}, reload: :always
  config.watch %r{app/javascript/.*}, reload: :always
  config.watch %r{app/helpers/.*}, reload: :always
  config.watch %r{config/locales/.+\.yml}, reload: :always
end if defined?(RailsLiveReload)
