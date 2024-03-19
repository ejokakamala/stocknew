# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate

ActiveRecord::Base.connection.tables.each do |income| 
  ActiveRecord::Base.connection.reset_pk_sequence!(income)
end

#if you have seeds to run add:
# bundle exec rails db:seed