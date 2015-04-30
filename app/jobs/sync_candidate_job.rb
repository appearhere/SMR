class SyncCandidateJob < ActiveJob::Base
  queue_as :default

  def perform(candidate)
    response = WorkableGateway.add_candidate(candidate.job.shortcode,
                                             candidate.to_json)

    if Net::HTTPSuccess === response
      candidate.touch(:added_to_workable_at)
    else
      candidate.update(last_error_at: Time.zone.now,
                       last_error_code: response.code,
                       last_error_message: response.body)
    end
  end
end
