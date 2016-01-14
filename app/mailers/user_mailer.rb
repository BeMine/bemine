class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
   default :from => "http://localhost:3000/"

    def notify_match(user, product)
        @product = product

        @user = user
        mail(:to => user.email, :subject => "New Order Request")
    end
end






