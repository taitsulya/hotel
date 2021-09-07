# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    describe 'it validates name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe 'it validates room_type' do
      it { is_expected.to validate_presence_of(:room_type) }
    end

    describe 'it validates price' do
      it { is_expected.to validate_presence_of(:price) }
    end

    describe 'it validates short_description' do
      it { is_expected.to validate_presence_of(:short_description) }
    end

    describe 'it validates full_description' do
      it { is_expected.to validate_presence_of(:full_description) }
    end
  end
end
