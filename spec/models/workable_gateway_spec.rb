require 'rails_helper'

describe WorkableGateway do
  describe 'generating a URL for accessing the API' do
    it "prepends the .base_uri" do
      expect(WorkableGateway.generate_url('/something'))
        .to start_with(WorkableGateway.base_uri.to_s)
    end

    it "appends the given path to the .base_uri" do
      path = URI(WorkableGateway.generate_url('/jobs')).path
      expect(path).to end_with('/jobs')
    end

    it "authenticates the url" do
      query = URI(WorkableGateway.generate_url('/jobs')).query
      expect(query).to start_with('access_token=')
    end

    it "adds any query params given" do
      url   = WorkableGateway.generate_url('/jobs',
                                           query: { phase: 'published' })
      query = URI(url).query
      expect(query).to include('phase=published')
    end
  end
end
