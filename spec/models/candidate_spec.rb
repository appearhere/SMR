require 'rails_helper'

describe Candidate do
  describe "getting the identity type" do
    it "always returns a symbol" do
      identity_type = Candidate.new(identity_type: 'holla').identity_type
      expect(identity_type).to eq(:holla)
    end

    context "the identity type is not nil" do
      it "returns nil" do
        expect(Candidate.new.identity_type).to be_nil
      end
    end
  end

  describe "getting the identity url" do
    it "returns the expected result for identities it knows" do
      candidate = Candidate.new(identity_type: 'twitter',
                                identity_id: 'clowder')
      expect(candidate.identity_url).to eq('https://twitter.com/clowder')
    end

    context "the record is invalid" do
      it "fails with an error message" do
        expect {
          Candidate.new.identity_url
        }.to raise_error('Invalid Candidate')
      end
    end
  end

  describe "creating a JSON representation" do
    it "generates a Workable friendly format" do
      candidate = Candidate.new(name: 'Chris Lowder',
                                email: 'clowder@gmail.com',
                                identity_type: 'twitter',
                                identity_id: 'clowder')

      expect(candidate.as_json).to eq({
        candidate: {
          name: 'Chris Lowder',
          email: 'clowder@gmail.com',
          social_profiles: [
            {
              type: 'twitter',
              username: 'clowder',
              url: 'https://twitter.com/clowder'
            }
          ],
        }
        sourced: true
      })
    end
  end
end

