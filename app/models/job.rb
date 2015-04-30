class Job < ActiveRecord::Base
  validates :shortcode, presence: true, uniqueness: true
  validates :title,     presence: true

  def to_param
    shortcode
  end
end
