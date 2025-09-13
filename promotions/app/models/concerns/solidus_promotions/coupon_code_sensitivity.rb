# frozen_string_literal: true

module SolidusPromotions
  module CouponCodeSensitivity
    extend ActiveSupport::Concern

    class_methods do
      def coupon_code_sensitive?
        SolidusPromotions.config.preferred_coupon_code_sensitive
      end
    end

    def coupon_code_sensitive?
      SolidusPromotions.config.preferred_coupon_code_sensitive
    end
  end
end
