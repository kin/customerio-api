require 'spec_helper'

describe CustomerioAPI::Client do
  let(:subject) { described_class.new('test_id', 'test_key') }

  describe '#messages' do
    it 'builds the correct url with one argument' do
      expect(subject).to receive(:request).with(:get, "/v1/api/messages?limit=4")
      allow(subject).to receive(:verify_response)

      subject.messages(limit: 4)
    end

    it 'builds the correct url with multiple arguments' do
      expect(subject).to receive(:request).with(:get, "/v1/api/messages?limit=4&start=1234")
      allow(subject).to receive(:verify_response)

      subject.messages(limit: 4, start: 1234)
    end

    it 'builds the correct url with no arguments' do
      expect(subject).to receive(:request).with(:get, "/v1/api/messages")
      allow(subject).to receive(:verify_response)

      subject.messages
    end
  end
end
