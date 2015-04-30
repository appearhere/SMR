class CandidatesController < ApplicationController
  def new
    job       = Job.new(shortcode: params[:job_id])
    candidate = Candidate.new
    render :new, locals: { job: job, candidate: candidate }
  end

  def create
    job       = Job.new(shortcode: params[:job_id])
    candidate = Candidate.new(post_params)

    if candidate.valid?
      WorkableGateway.add_candidate(job, candidate)

      flash[:success] = 'Candidate saved.'
      redirect_to jobs_path
    else
      render :new, locals: { job: job, candidate: candidate }
    end
  end

  private
  def post_params
    params[:candidate].slice(:name, :email, :identity_type, :identity_id)
  end
end
