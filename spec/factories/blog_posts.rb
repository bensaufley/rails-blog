FactoryGirl.define do
  factory :blog_post do
    title { Faker::Lorem.sentence((4..8).to_a.sample) }
    content { Faker::Lorem.paragraphs.join("\n\n") }
    tags { Faker::Lorem.words((2..6).to_a.sample).join(',') }
    slug ''
  end
end
