class Job < ActiveRecord::Base
  validates :shortcode, presence: true, uniqueness: true
  validates :title,     presence: true

  has_many :candidates

  def to_param
    shortcode
  end

  def new_candidate(attrs={})
    candidate = Candidate.new(attrs)
    candidate.job = self
    candidate
  end
end
