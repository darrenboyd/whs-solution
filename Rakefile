# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require 'csv'

Rails.application.load_tasks

task load_data: :environment do
  Unit.delete_all
  CSV.open('../developer-interview/assets/units-and-residents.csv') do |csv|
    csv.readline # skip over the headers
    while row_data = csv.readline
      Unit.create!({
        unit_number: row_data[0],
        floor_plan: row_data[1],
        resident: row_data[2],
        move_in: row_data[3],
        move_out: row_data[4],
      })
    end
  end
end
