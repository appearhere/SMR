class JobsController < ApplicationController
  class Job < Value.new(:title, :shortcode)
  end

  module WorkableGateway
    URI = "http://www.workable.com/spi/v2/accounts/appearhere/jobs?phase=published&access_token=#{ Rails.configuration.workable_token }"

    def self.jobs
      json = Rails.cache.fetch('job-list', expires_in: 3.hour) { open(URI).read }
      data = ActiveSupport::JSON.decode(json)['jobs']
      data
        .map { |datum| Job.new(*datum.slice('title', 'shortcode').values) }
        .sort_by(&:title)
    end
  end

  def index
    jobs = WorkableGateway.jobs
    render :index, locals: { jobs: jobs }
  end
end
