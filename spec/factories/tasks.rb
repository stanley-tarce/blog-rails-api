FactoryBot.define do 
    factory :task do
        category
        title { Faker::Name.name}
        description { Faker::Name.name}
        task_date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    end
end