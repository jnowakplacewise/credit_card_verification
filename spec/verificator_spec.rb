# frozen_string_literal: true

require_relative '../lib/credit/verificator'
require_relative '../lib/credit/card'

describe Credit::CardVerificator do
  let(:ver) { Credit::CardVerificator.new }
  describe '#clean_code' do
    context 'given 11-22-33' do
      it 'returns 112233' do
        expect(ver.clean_code('11-22-33')).to eq('112233')
      end
    end
    context 'given 11-22-3-' do
      it 'not returns 112233-' do
        expect(ver.clean_code('11-22-33-')).not_to eq('112233-')
      end
    end
  end

  describe '#check_alpha' do
    context 'given 1h12aa' do
      it 'is invalid (false)' do
        expect(ver.check_alpha('1h12aa')).to be(false)
      end
    end
    context 'given 1h12aag' do
      it 'is not valid (true)' do
        expect(ver.check_alpha('1h12aag')).not_to be(true)
      end
    end
  end

  describe '#check_prefix' do
    context 'given 371h12aa' do
      it 'is not invalid (true)' do
        expect(ver.check_prefix('371h12aa')).not_to be(false)
      end
    end
    context 'given 371h12aa' do
      it 'is valid (true)' do
        expect(ver.check_prefix('371h12aa')).to be(true)
      end
    end
    context 'given 31h12aa' do
      it 'is not valid (false)' do
        expect(ver.check_prefix('1h12aa')).to be(false)
      end
    end
  end

  describe '#check_length' do
    context 'given valid code' do
      it 'is valid length (true)' do
        %w[378282246310005
           371449635398431
           5555555555554444
           5105105105105100
           4111111111111111
           4012888888881881
           4012312313213121].each do |code|
          expect(ver.check_length(code)).to be(true)
        end
      end
    end
    context 'given 37828220005' do
      it 'is valid (false)' do
        expect(ver.check_length('37828220005')).to be(false)
      end
    end
  end

  describe '#verify' do
    context 'given valid code AMEX' do
      it 'is valid (AMEX)' do
        %w[378282246310005
           371449635398431].each do |code|
          expect(ver.verify(Credit::Card.new(1, code, 'Jakub Nowak'))).to eq('AMEX')
        end
      end
    end
    context 'given valid code MASTERCARD' do
      it 'is valid (MASTERCARD)' do
        %w[5555555555554444
           5105105105105100].each do |code|
          expect(ver.verify(Credit::Card.new(3, code, 'Jakub Nowak'))).to eq('MASTERCARD')
        end
      end
    end
    context 'given valid code VISA' do
      it 'is valid (VISA)' do
        %w[4111111111111111
           4012888888881881].each do |code|
          expect(ver.verify(Credit::Card.new(5, code, 'Jakub Nowak'))).to eq('VISA')
        end
      end
    end
  end
end
