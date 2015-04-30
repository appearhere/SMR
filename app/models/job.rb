class Job
  include ActiveModel::Model

  attr_accessor :title, :shortcode

  def to_param
    shortcode
  end
end
