# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


def create_users_and_companies
  puts 'Creating 5 candidates'
  5.times do
    user = User.new(
      email: Faker::Internet.unique.email,
      password: '12345678',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: '+33 6 12 34 56 78',
      profile: Faker::Lorem.sentence,
      is_candidate: true
      )
    puts user
    puts user.save
  end
  puts 'Creating 2 recruiters, name prefixed with Emp'
  2.times do |i|
    user = User.new(
      email: Faker::Internet.unique.email,
      password: 'bidule',
      first_name: Faker::Name.first_name,
      last_name: "Emp #{Faker::Name.last_name}",
      phone_number: '+33 6 00 00 00 00',
      is_candidate: false
      )
    puts user
    puts 'Creating 1 company per recruiter'
    company = Company.new(
      name: ["Le Wagon", "Hey_Laura"][i] ,
      location: ["16 villa Gaudelet Paris", "12 rue de Rivoli Paris"][i] ,
      industry: "Test industry",
      description: Faker::Lorem.sentence,
      # TODO: picture et logos
      user: user
      )
    puts "save user ?"
    puts user.save
    puts "save company ?"
    puts company.save
  end
end

def create_job_and_candidates
  puts 'Creating 100 jobs and associated job requests'
  100.times do |i|
    date = Date.today + rand(30..180)
    job = Job.new(
      title: Faker::Job.title,
      start_date: date,
      end_date: date + rand(1..100),
      monthly_salary: rand(15..22) * 100,
      description: Faker::Lorem.sentence,
      profile: Faker::Lorem.sentence,
      company: Company.all.sample
      )
    puts 'save job ?'
    puts job.save
    if rand < 0.66 # Deux chances sur trois d avoir des candidats
      candidates_number = rand(1..4)
      candidates = User.where(is_candidate: true).sample(candidates_number)
      candidates.each do |candidate|
        jr = JobRequest.new(
          current_status: %w(pending refused accepted).sample,
          job: job,
          user: candidate,
          message: Faker::Lorem.sentence
          )
        puts 'save job request ?'
        puts jr.save
      end
    end
  end
end

create_users_and_companies
create_job_and_candidates
