class JobsController < ApplicationController
  def index
    jobs = Job.all
    render :index, locals: { jobs: jobs }
  end
end
