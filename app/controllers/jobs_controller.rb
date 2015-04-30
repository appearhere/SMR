class JobsController < ApplicationController
  def index
    jobs = WorkableGateway.jobs
    render :index, locals: { jobs: jobs }
  end
end
