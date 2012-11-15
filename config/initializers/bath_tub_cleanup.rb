expired_bathtubs = BathTub.where(:updated_at.lt => 1.month.ago)
expired_bathtubs.each do |eb|
  eb.order.destroy
  eb.destroy
end