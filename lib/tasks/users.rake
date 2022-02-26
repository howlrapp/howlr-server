namespace :users do
  task :remove_idle => :environment do
    Users::RemoveIdleJob.perform_now
  end

  task :generate_apple_sign_up_code => :environment do
    puts Session.generate_code
  end
end
