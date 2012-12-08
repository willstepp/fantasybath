ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "democravise.com",
  :user_name            => "democravise@democravise.com",
  :password             => ENV['GMAIL_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}