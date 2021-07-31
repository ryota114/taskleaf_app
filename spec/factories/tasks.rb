FactoryBot define do
  factory :task do
    name { "テストを書く" }
    describe { "RSpec & Capybara & FactoryBotを準備する" }
    user
  end 
end