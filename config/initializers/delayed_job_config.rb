if Delayed::Worker.delay_jobs = Rails.env.dev?
  Delayed::Worker.delay_jobs = false
end