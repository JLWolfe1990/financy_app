SignupService.perform(
               {
                 tenant: {
                   name: 'Wolfe Family'
                 },
                 user: {
                   email: 'jwolfe@wfsbs.com',
                   password: 'fakepass',
                   password_confirmation: 'fakepass'
                 }
               }
)

ActiveRecord::Base.transaction do
  Classification.destroy_all

  Classification.create! group: Classification.groups[:mixed], name: 'Amazon'
  Classification.create! group: Classification.groups[:mixed], name: 'Gas'
  Classification.create! group: Classification.groups[:mixed], name: 'Housing'
  Classification.create! group: Classification.groups[:mixed], name: 'Money Transfer'
  Classification.create! group: Classification.groups[:mixed], name: 'Student Loans'
  Classification.create! group: Classification.groups[:mixed], name: 'Debt Payment'
  Classification.create! group: Classification.groups[:mixed], name: 'Cash'
  Classification.create! group: Classification.groups[:mixed], name: 'Ignore'
  Classification.create! group: Classification.groups[:mixed], name: 'Misc'


  Classification.create! group: Classification.groups[:business], name: 'Materials & Supplies'
  Classification.create! group: Classification.groups[:business], name: 'Credit Cards'
  Classification.create! group: Classification.groups[:business], name: 'Services'
  Classification.create! group: Classification.groups[:business], name: 'Misc'
  Classification.create! group: Classification.groups[:business], name: 'Communication'
  Classification.create! group: Classification.groups[:business], name: 'Travel'
  Classification.create! group: Classification.groups[:business], name: 'Banking Fee'

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

  PlaidInstitution.destroy_all
  PlaidInstitution.refresh!
end
