# frozen_string_literal: true

module SolidusPromotions
  class CaseInsensitiveCode
    def self.call(value)
      value&.strip&.downcase
    end
  end
end
