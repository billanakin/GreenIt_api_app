FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "$2a$12$0CoQ3sl.ftNgVbeM2xnkFuTdqWBO2YkuDepuSvQZwfc/cCk/efria" } # @secret123
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
