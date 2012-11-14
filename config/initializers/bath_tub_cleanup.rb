expired_bathtubs = BathTub.where(:updated_at.gt => 1.month.ago)
expired_bathtubs.each do |eb|
  eb.destroy
end