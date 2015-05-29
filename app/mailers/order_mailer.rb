class OrderMailer < ActionMailer::Base
  default :from => 'kashisme@msn.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: 'Order has been received')
  end

  # def order_notification_to_admin(admin)
  #   @admin = admin
  #   mail( :to => @admin.email,
  #   :subject => 'An order has been placed in your store' )
  # end
end
