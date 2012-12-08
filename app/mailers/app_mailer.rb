class AppMailer < ActionMailer::Base
  default from: "admin@fantasybath.com"

  def order_processed(email, name, order_number)
    @name = name
    @order_id = order_number
    mail(:reply_to => "admin@fantasybath.com", :to => email, :subject => "Fantasy Bath - Thanks for your order!")
  end

  def order_shipped(email, name, order_number)
    @name = name
    @order_id = order_number
    mail(:reply_to => "admin@fantasybath.com", :to => email, :subject => "Fantasy Bath - Your order has shipped!")
  end
end
