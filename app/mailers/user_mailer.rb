class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  default from: 'http://localhost:3000/'

  def notify_match(user, order, fulfill_request)
    @user = user
    @order = order
    @product = order.line_item.product
    @token = fulfill_request.token

    mail(to: @user.email, subject: 'New Order Request')
  end

  def notify_match_success(user, order)
    @user = user
    @order = order
    @product = order.line_item.product

    mail(to: order.user.email, subject: 'Confirm Request')
  end
end
