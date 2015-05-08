class Candidate < ActiveRecord::Base
  IDENTITY_TYPES = %i{ angellist dribbble github twitter }
  IDENTITY_URLS = {
    angellist: 'https://angel.co/{ID}',
    dribbble: 'https://dribbble.com/{ID}',
    github: 'https://github.com/{ID}',
    twitter: 'https://twitter.com/{ID}'
  }

  validates :name,          presence: true
  validates :email,         presence: true, uniqueness: true
  validates :identity_type, inclusion: { in: IDENTITY_TYPES, allow_blank: true }

  belongs_to :job

  def self.identity_types
    IDENTITY_TYPES
  end

  def identity_type
    val = super()
    val ? val.to_sym : val
  end

  def identity_url
    fail 'Invalid Candidate' unless valid?

    IDENTITY_URLS[identity_type].gsub(/{ID}/, identity_id)
  end

  def added_to_workable?
    added_to_workable_at?
  end

  def as_json(*_)
    {
      candidate: {
        name: name,
        email: email,
        social_profiles: [
          {
            type: identity_type.to_s,
            username: identity_id,
            url: identity_url
          }
        ]
      },
      sourced: true
    }
  end
end

