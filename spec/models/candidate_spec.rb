require 'rails_helper'

describe Candidate do
  describe "validations" do
    context "a identity_type is given" do
      subject(:candidate) { Candidate.new(identity_type: :twitter) }
      it { is_expected.to validate_presence_of(:identity_id) }
    end

    context "a identity_id is given" do
      subject(:candidate) { Candidate.new(identity_id: 'clowder') }
      it { is_expected.to validate_presence_of(:identity_type) }
    end
  end

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
      candidate = Candidate.new(name: 'Chris Lowder',
                                email: 'clowder@gmail.com',
                                identity_type: 'twitter',
                                identity_id: 'clowder')
      expect(candidate.identity_url).to eq('https://twitter.com/clowder')
    end

    context "the record is invalid" do
      it "fails with an error message" do
        candidate = Candidate.new(name: 'Chris Lowder',
                                  email: 'clowder@gmail.com',
                                  identity_type: 'monkey',
                                  identity_id: 'wat')
        expect {
          candidate.identity_url
        }.to raise_error('Invalid Candidate')
      end
    end

    context "all identity info is blank" do
      it "returns nil" do
        candidate = Candidate.new(name: 'Chris Lowder',
                                  email: 'clowder@gmail.com')
        expect(candidate.identity_url).to be_nil
      end
    end
  end

  describe "creating a JSON representation" do
    it "generates a Workable friendly format" do
      candidate = Candidate.new(name: 'Chris Lowder',
                                email: 'clowder@gmail.com',
                                headline: 'http://clowder.name',
                                identity_type: 'twitter',
                                identity_id: 'clowder')

      expect(candidate.as_json).to eq({
        candidate: {
          name: 'Chris Lowder',
          email: 'clowder@gmail.com',
          headline: 'http://clowder.name',
          social_profiles: [
            {
              type: 'twitter',
              username: 'clowder',
              url: 'https://twitter.com/clowder'
            }
          ]
        },
        sourced: true
      })
    end

    context "the user has none of the optional info" do
      it "generates a Workable friendly format" do
        candidate = Candidate.new(name: 'Chris Lowder',
                                  email: 'clowder@gmail.com')

        expect(candidate.as_json).to eq({
          candidate: {
            name: 'Chris Lowder',
            email: 'clowder@gmail.com'
          },
          sourced: true
        })
      end
    end
  end
end

