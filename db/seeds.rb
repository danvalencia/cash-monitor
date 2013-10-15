# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!({email: 'danvalencia@gmail.com', password: 'password', password_confirmation: 'password', first_name: 'Daniel', last_name: 'Valencia', phone_number: '415-283-9462', admin: true})
User.create!({email: 'juanmarcosvalencia@gmail.com', password: 'password', password_confirmation: 'password', first_name: 'Juan Marcos', last_name: 'Valencia', phone_number: '+52 1 (55) 4566 9412', admin: true})
