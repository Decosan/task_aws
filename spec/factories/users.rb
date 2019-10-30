FactoryBot.define do
  factory :user do
    name { "sample" }
    email { "sample@123.com"}
    password {"sample123"}
    password_confirmation {"sample123"}
  end

  # FactoryBot.create(:user_with_tasks) do
  #   transient do
  #     tasks_count 3
  #   end

  #   after(:create) do |user, evaluator|
  #     create_list(:tasks, evaluator.tasks_count, user: user)
  #   end
  # end
end
  # FactoryBot.create(:user, :with_3_tasks)
  #   trait(:with_3_tasks) do
  #     name { "with_3" }
  #   end
  

  #   after(:create) do |user|
  #     3.times { create(:task, user: user) }
  #   end
  # end
# end
 