# frozen_string_literal: true

module Spree
  class MergeableOrdersFinder
    def initialize(user:, store:, current_order:)
      @user = user
      @store = store
      @current_order = current_order
    end

    # return an order that should be merged into current order @ below can be used to find orders to merge rather than hardcoding it in the controller
    def call
      @user.orders
        .by_store(@store)
        .incomplete
        .where.not(id: @current_order.id)
    end
  end
end
