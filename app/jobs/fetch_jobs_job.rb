class FetchJobsJob < ActiveJob::Base
  queue_as :default

  def perform
    WorkableGateway.jobs.each do |job_data|
      Job.find_or_create_by(shortcode: job_data['shortcode']) do |job|
        job.title = job_data['title']
      end
    end
  end
end
