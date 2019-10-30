FactoryBot.define do
  
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    created_at {Date.today-5}
    sort_expired {Date.today+8}
    status {'Pending'}
    priority {'Mid'}
    user
  end

end