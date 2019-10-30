namespace :expired_announcement do
  desc "アナウンスメールの送信"
  task mail: :environment do

    users = User.left_joins(:tasks).merge(Task.where(sort_expired: Date.today - 3..Date.today)).uniq
    users.each do |user|
      ContactMailer.contact_mail(user).deliver
    end
  end
end
