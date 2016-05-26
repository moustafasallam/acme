# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "===========seeding job Posting====================\n"
(1..10).each do |n|
	JobPosting.create!(title: Faker::Lorem.sentence,
									description: Faker::Lorem.paragraph(2),
									closing_date: Time.now + rand(50..100).days
								)
end

puts "============seeding candidates=====================\n"
(1..100).each do |n|
	Candidate.create!(name: Faker::Name.name,
									email: Faker::Internet.email,
									cover_letter: Faker::Lorem.paragraph(2),
									job_posting_id: JobPosting.order("RAND()").first.id
								)
end
