# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(HomePolicy) do
  subject { HomePolicy.new(admin, home) }

  let(:home) { FactoryBot.create(:home) }

  context 'for an admin' do
    let(:admin) { FactoryBot.create(:admin) }
    it { should permit(:index) }
    it { should permit(:update) }
  end

  context 'for a visitor' do
    let(:admin) { nil }
    it { should permit(:index) }
    it { should_not permit(:update) }
  end
end
