Rails.configuration.stripe = {
  #for deploy set ENV with: export PUBLISHABLE_KEY=api & export SECRET_KEY=api 
  # :publishable_key => ENV['PUBLISHABLE_KEY'],
  # :secret_key      => ENV['SECRET_KEY']
  #test 
  :publishable_key => "pk_test_lHHNk97Kwh4kimimsENGlZMy",
  :secret_key      => "sk_test_33WQlATaH57Wp06O9xuiE1hj"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]