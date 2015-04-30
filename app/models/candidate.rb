class Candidate
  include ActiveModel::Model
  attr_accessor :name, :email, :identity_type, :identity_id

  IDENTITY_TYPES = %i{ angellist dribbble github twitter }
  IDENTITY_URLS = {
    angellist: 'https://angel.co/{ID}',
    dribbble: 'https://dribbble.com/{ID}',
    github: 'https://github.com/{ID}',
    twitter: 'https://twitter.com/{ID}'
  }

  validates :name,          presence: true
  validates :email,         presence: true
  validates :identity_type, presence: true, inclusion: { in: IDENTITY_TYPES }
  validates :identity_id,   presence: true

  def self.identity_types
    IDENTITY_TYPES
  end

  def identity_type
    @identity_type ? @identity_type.to_sym : @identity_type
  end

  def identity_url
    fail 'Invalid Candidate' unless valid?

    IDENTITY_URLS[identity_type].gsub(/{ID}/, identity_id)
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

