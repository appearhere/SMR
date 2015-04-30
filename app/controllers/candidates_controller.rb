class CandidatesController < ApplicationController
  def index
    job        = Job.find_by(shortcode: params[:job_id])
    candidates = job.candidates

    render :index, locals: { job: job, candidates: candidates }
  end

  def new
    job       = Job.find_by(shortcode: params[:job_id])
    candidate = job.new_candidate

    render :new, locals: { job: job, candidate: candidate }
  end

  def create
    job       = Job.find_by(shortcode: params[:job_id])
    candidate = job.new_candidate(post_params)

    if candidate.save
      SyncCandidateJob.perform_later(candidate)
      flash[:success] = 'Candidate saved.'
      redirect_to jobs_path
    else
      render :new, locals: { job: job, candidate: candidate }
    end
  end

  private
  def post_params
    params.require(:candidate).permit(:name, :email, :identity_type,
                                      :identity_id)
  end
end
