# frozen_string_literal: true

class AuthHelperTest
  include MappingService::Auth::AuthenticationHelper

  def error!(msg, code); end

  def headers
    {}
  end
end

RSpec.describe AuthHelperTest do
  subject { described_class.new }

  let(:api_key) { build(:api_key) }

  describe '#authorize_admin!' do
    it 'calls error! if user is not an admin' do
      allow(subject).to receive(:current_user).and_return(api_key)
      allow(api_key).to receive(:admin).and_return(false)

      expect(subject).to receive(:error!)

      subject.authorize_admin!
    end

    it 'calls error! if user is nil' do
      allow(subject).to receive(:current_user).and_return(nil)

      expect(subject).to receive(:error!)

      subject.authorize_admin!
    end

    it 'returns nil if user is an admin' do
      allow(subject).to receive(:current_user).and_return(api_key)

      expect(subject).to_not receive(:error!)

      subject.authorize_admin!
    end
  end

  describe '#current_user' do
    it 'returns the ApiKey if found and not expired' do
      allow_any_instance_of(MappingService::Auth::ApiKeyRepository).to receive(:find_by_key).and_return(api_key)

      expect(subject.current_user).to eq(api_key)
    end

    it 'returns nil if the ApiKey is expired' do
      allow_any_instance_of(MappingService::Auth::ApiKeyRepository).to receive(:find_by_key).and_return(api_key)
      allow(api_key).to receive(:expired?).and_return(true)

      expect(subject.current_user).to be_nil
    end

    it "returns nil if the key isn't found" do
      allow_any_instance_of(MappingService::Auth::ApiKeyRepository).to receive(:find_by_key).and_return(nil)

      expect(subject.current_user).to be_nil
    end
  end
end
