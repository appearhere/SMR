namespace :workable do
  task :fetch_jobs => :environment do
    FetchJobsJob.perform_later
  end

  task :sync => :environment do
    Candidate.where(added_to_workable_at: nil).find_each do |candidate|
      SyncCandidateJob.perform_later(candidate)
    end
  end
end
