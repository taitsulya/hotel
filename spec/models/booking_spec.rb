# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Booking, type: :model) do
  describe 'validations' do
    describe 'it validates name' do
      it { is_expected.to(validate_presence_of(:name)) }
    end

    describe 'it validates email' do
      it { is_expected.to(validate_presence_of(:email)) }
    end

    describe 'it validates mobile_phone' do
      it { is_expected.to(validate_presence_of(:mobile_phone)) }
    end
  end
end
