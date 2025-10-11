# frozen_string_literal: true

require "rails_helper"

RSpec.describe SolidusPromotions::CaseInsensitiveCode do
  describe '.call' do
    context 'when case is insensitive' do
      it 'downcases the value' do
        expect(described_class.call('10FFF')).to eq('10fff')
      end

      it "strips leading and trailing whitespace" do
        expect(described_class.call("  10oFF  ")).to eq("10off")
      end

      it 'downcases mixed cases' do
        expect(described_class.call('10OfF')).to eq('10off')
      end

      it 'handles already normalized values' do
        expect(described_class.call('10off')).to eq('10off')
      end

      it 'return nil with nil input' do
        expect(described_class.call(nil)).to be_nil
      end

      it 'return empty string with empty string input' do
        expect(described_class.call('')).to eq('')
      end

      it 'return empty string with whitespace only input' do
        expect(described_class.call('   ')).to eq('')
      end
    end

    context 'when case is sensitive' do
      before do
        stub_const("CaseSensitiveNormalizer", Class.new do
          def self.call(value)
            value&.strip
          end
        end)

        stub_spree_preferences(
          SolidusPromotions.configuration,
          coupon_code_normalizer_class: CaseSensitiveNormalizer
        )
      end

      it 'preserved the original cases' do
        expect(CaseSensitiveNormalizer.call('10OFF')).to eq('10OFF')
      end

      it 'does not downcase the value' do
        expect(CaseSensitiveNormalizer.call('10OFF')).not_to eq('10off')
      end

      it 'strips leading and trailing whitespace' do
        expect(CaseSensitiveNormalizer.call(' 10OFF ')).to eq('10OFF')
      end

      it 'preserves lower case' do
        expect(CaseSensitiveNormalizer.call('10off')).to eq('10off')
      end

      it 'preserved mixed case' do
        expect(CaseSensitiveNormalizer.call('10OfF')).to eq('10OfF')
      end

      it 'return nil with nil input' do
        expect(CaseSensitiveNormalizer.call(nil)).to be_nil
      end

      it 'return empty string with empty string input' do
        expect(CaseSensitiveNormalizer.call('')).to eq('')
      end

      it 'return empty string with whitespace only input' do
        expect(CaseSensitiveNormalizer.call('   ')).to eq('')
      end
    end
  end
end
