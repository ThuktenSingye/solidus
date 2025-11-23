# frozen_string_literal: true

require 'rails_helper'
module Spree
  RSpec.describe MergeableOrdersFinder do
    let(:user) { create(:user) }
    let(:store) { create(:store) }
    let(:current_order) { create(:order, user: user, store: store) }
    let(:subject) { Spree::MergeableOrdersFinder.new(user: user, store: store, current_order: current_order) }

    describe '#call' do
      let!(:incomplete_order1) { create(:order, user: user, store: store, state: 'cart') }
      let!(:incomplete_order2) { create(:order, user: user, store: store, state: 'address') }
      let!(:complete_order) { create(:order, user: user, store: store, state: 'complete').touch(:completed_at) }
      let!(:other_store_order) { create(:order, user: user, state: 'cart') }

      it 'returns incomplete orders from the same store' do
        orders = subject.call
        expect(orders).to include(incomplete_order1, incomplete_order2)
        expect(orders).not_to include(current_order, complete_order, other_store_order)
      end
    end
  end
end
