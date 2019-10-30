class ContactMailer < ApplicationMailer
  def contact_mail(user)
    @user = user

    mail to: "junx0401@gmail.com", subject: "期限が間近となっているタスクのお知らせ"
  end
end
