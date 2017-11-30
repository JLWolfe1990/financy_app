# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

ActiveRecord::Base.transaction do
  Classification.destroy_all

  Classification.create! group: Classification.groups[:mixed], name: 'Amazon'
  Classification.create! group: Classification.groups[:mixed], name: 'Gas'
  Classification.create! group: Classification.groups[:mixed], name: 'Housing'
  Classification.create! group: Classification.groups[:mixed], name: 'Money Transfer'
  Classification.create! group: Classification.groups[:mixed], name: 'Student Loans'
  Classification.create! group: Classification.groups[:mixed], name: 'Debt Payment'
  Classification.create! group: Classification.groups[:mixed], name: 'Cash'


  Classification.create! group: Classification.groups[:business], name: 'Materials & Supplies'
  Classification.create! group: Classification.groups[:business], name: 'Credit Cards'
  Classification.create! group: Classification.groups[:business], name: 'Services'
  Classification.create! group: Classification.groups[:business], name: 'Misc'
  Classification.create! group: Classification.groups[:business], name: 'Communication'
  Classification.create! group: Classification.groups[:business], name: 'Travel'

  Classification.create! group: Classification.groups[:personal], name: 'Clothing'
  Classification.create! group: Classification.groups[:personal], name: 'Investments'
  Classification.create! group: Classification.groups[:personal], name: 'Health'
  Classification.create! group: Classification.groups[:personal], name: 'Fitness'
  Classification.create! group: Classification.groups[:personal], name: 'Automotive'
  Classification.create! group: Classification.groups[:personal], name: 'Automotive Insurance'
  Classification.create! group: Classification.groups[:personal], name: 'Groceries'
  Classification.create! group: Classification.groups[:personal], name: 'Dinning Out'
  Classification.create! group: Classification.groups[:personal], name: 'Hobbies'
  Classification.create! group: Classification.groups[:personal], name: 'Travel'
  Classification.create! group: Classification.groups[:personal], name: 'Tolls'
  Classification.create! group: Classification.groups[:personal], name: 'Entertainment'
  Classification.create! group: Classification.groups[:personal], name: 'Misc'
end
