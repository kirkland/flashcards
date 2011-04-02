Sass::Plugin.options[:always_update] = true if Rails.env.development?
Sass::Plugin.options[:template_location] = "#{RAILS_ROOT}/app/stylesheets" if Rails.env.development?
