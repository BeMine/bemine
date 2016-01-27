class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  default from: 'http://localhost:3000/'

  def notify_match(user, order, product, token)
    @product = product
    @order = order
    @user = user
    @token = token

    mail(to: order.user.email, subject: 'New Order Request')
  end

  def notify_match_success(user, product, order)
    @order = order
    @product = product
    @user = user

    mail(to: order.user.email, subject: 'Confirm Request')
  end
end
