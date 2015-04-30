require 'addressable/uri'

module WorkableGateway
  BASE_URI = Addressable::URI
              .parse("http://www.workable.com/spi/v2/accounts/appearhere")
  TOKEN    = Rails.configuration.workable_token

  def self.base_uri
    BASE_URI
  end

  def self.jobs
    url  = generate_url('/jobs', query: { phase: 'published' })
    json = get_cached(url)
    data = ActiveSupport::JSON.decode(json)['jobs']
    data
      .map { |datum| Job.new(datum.slice('title', 'shortcode')) }
      .sort_by(&:title)
  end

  def self.add_candidate(job, candidate)
    uri  = URI(generate_url("/jobs/#{ job.shortcode }/candidates"))
    resp = nil

    Net::HTTP.start(uri.host) do |http|
      resp = http.post(uri.path, candidate.to_json, { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ TOKEN }" })
    end

    resp
  end

  def self.generate_url(path, query: {})
    query = query.merge(access_token: TOKEN)
    path  = File.join(base_uri.path, path)
    uri   = base_uri.merge(path: path)

    uri.query_values = query
    uri.to_s
  end

  private
  def self.get_cached(url)
    hash = Digest::SHA256.hexdigest(url)
    Rails.cache.fetch(hash, expires_in: 3.hour) { open(url).read }
  end
end

