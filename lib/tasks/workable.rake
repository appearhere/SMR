namespace :workable do
  task :fetch_jobs => :environment do
    FetchJobsJob.perform_later
  end
end
