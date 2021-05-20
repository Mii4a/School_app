source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',        '5.2.4'
gem 'bcrypt',        '3.1.12'
gem 'faker'
gem 'carrierwave',   '1.2.2'
gem 'counter_culture'
gem 'mini_magick',   '4.7.0'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'bootstrap-sass', '3.4.1'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jquery-turbolinks'
gem 'jbuilder',     '2.7.0'
gem 'slim'
gem 'slim-rails'
gem 'html2slim'
gem 'bootsnap'
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons' 
gem 'rails-i18n', '~> 5.1' # For 5.0.x, 5.1.x and 5.2.x
gem 'rmagick'

group :production do
  gem 'pg', '0.20.0'
end

group :development, :test do
  gem 'sqlite3',             '1.3.13'
  gem 'byebug',              '9.0.6', platform: :mri
  gem 'rspec-rails',         '~> 4.0.0.beta'
  gem 'factory_bot_rails',   '5.0.2'
  gem 'capybara'
  gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec'
end


# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]