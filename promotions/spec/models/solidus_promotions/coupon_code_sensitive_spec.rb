# frozen_string_literal: true

require "rails_helper"

RSpec.describe SolidusPromotions::CouponCodeSensitivity do
  let(:test_class) do
    Class.new do
      include SolidusPromotions::CouponCodeSensitivity

      def self.model_name
        ActiveModel::Name.new(self, nil, "test_class")
      end
    end
  end

  describe "#coupon_code_sensitive?" do
    subject { test_class.new.coupon_code_sensitive? }

    context "when preferred_coupon_code_sensitive is false (default)" do
      it "returns false" do
        expect(subject).to be false
      end
    end

    context "when preferred_coupon_code_sensitive is true" do
      before { stub_spree_preferences(SolidusPromotions.configuration, preferred_coupon_code_sensitive: true) }

      it "returns true" do
        expect(subject).to be true
      end
    end
  end

  describe '.coupon_code_sensitive?' do
    subject { test_class.coupon_code_sensitive? }

    context "when preferred_coupon_code_sensitive is false (default)" do
      it "returns false" do
        expect(subject).to be false
      end
    end

    context "when preferred_coupon_code_sensitive is true" do
      before { stub_spree_preferences(SolidusPromotions.configuration, preferred_coupon_code_sensitive: true) }

      it "returns true" do
        expect(subject).to be true
      end
    end
  end
end
