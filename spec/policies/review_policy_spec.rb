# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ReviewPolicy) do
  subject { ReviewPolicy.new(admin, review) }

  let(:review) { FactoryBot.create(:review) }

  context 'for an admin' do
    let(:admin) { FactoryBot.create(:admin) }
    it { should permit(:index) }
    it { should_not permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a visitor' do
    let(:admin) { nil }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
end
