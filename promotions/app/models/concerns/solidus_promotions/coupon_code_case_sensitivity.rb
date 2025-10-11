# frozen_string_literal: true

module SolidusPromotions
  module CouponCodeCaseSensitivity
    extend ActiveSupport::Concern

    class_methods do
      def coupon_code_case_sensitive?
        SolidusPromotions.config.preferred_coupon_code_case_sensitive
      end
    end

    def coupon_code_case_sensitive?
      SolidusPromotions.config.preferred_coupon_code_case_sensitive
    end
  end
end
