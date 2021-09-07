# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    describe 'it validates author_name' do
      it { is_expected.to validate_presence_of(:author_name) }
    end

    describe 'it validates author_email' do
      it { is_expected.to validate_presence_of(:author_email) }
    end

    describe 'it validates body' do
      it { is_expected.to validate_presence_of(:body) }
    end
  end
end
