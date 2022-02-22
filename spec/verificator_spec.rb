# frozen_string_literal: true

require_relative '../lib/credit/verificator'
require_relative '../lib/credit/card'

describe Credit::CardVerificator do
  describe '#clean_code' do
    context 'given 11-22-33' do
      it 'returns 112233' do
        ver = Credit::CardVerificator.new

        expect(ver.clean_code('11-22-33')).to eq('112233')
      end
    end
    context 'given 11-22-33' do
      it 'returns 112233' do
        ver = Credit::CardVerificator.new

        expect(ver.clean_code('11-22-33')).not_to eq('112233-')
      end
    end
  end

  describe '#check_alpha' do
    context 'given 1h12aa' do
      it 'is invalid (false)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_alpha('1h12aa')).to be(false)
      end
    end
    context 'given 1h12aag' do
      it 'is not valid (true)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_alpha('1h12aag')).not_to be(true)
      end
    end
  end

  describe '#check_prefix' do
    context 'given 371h12aa' do
      it 'is not invalid (true)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_prefix('371h12aa')).not_to be(false)
      end
    end
    context 'given 371h12aa' do
      it 'is valid (true)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_prefix('371h12aa')).to be(true)
      end
    end
    context 'given 31h12aa' do
      it 'is not valid (false)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_prefix('1h12aa')).to be(false)
      end
    end
  end

  describe '#check_length' do
    context 'given valid code' do
      it 'is valid length (true)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_length('378282246310005')).to be(true)
        expect(ver.check_length('371449635398431')).to be(true)
        expect(ver.check_length('5555555555554444')).to be(true)
        expect(ver.check_length('5105105105105100')).to be(true)
        expect(ver.check_length('4111111111111111')).to be(true)
        expect(ver.check_length('4012888888881881')).to be(true)
      end
    end
    context 'given 37828220005' do
      it 'is valid (true)' do
        ver = Credit::CardVerificator.new
        expect(ver.check_length('37828220005')).to be(false)
      end
    end
  end

  describe '#verify' do
    context 'given valid code AMEX' do
      it 'is valid (AMEX)' do
        ver = Credit::CardVerificator.new
        expect(ver.verify(Credit::Card.new(1, '378282246310005', 'Jakub Nowak'))).to eq('AMEX')
        expect(ver.verify(Credit::Card.new(2, '371449635398431', 'Jakub Nowak'))).to eq('AMEX')
      end
    end
    context 'given valid code MASTERCARD' do
      it 'is valid (MASTERCARD)' do
        ver = Credit::CardVerificator.new
        expect(ver.verify(Credit::Card.new(3, '5555555555554444', 'Jakub Nowak'))).to eq('MASTERCARD')
        expect(ver.verify(Credit::Card.new(4, '5105105105105100', 'Jakub Nowak'))).to eq('MASTERCARD')
      end
    end
    context 'given valid code VISA' do
      it 'is valid (VISA)' do
        ver = Credit::CardVerificator.new
        expect(ver.verify(Credit::Card.new(5, '4111111111111111', 'Jakub Nowak'))).to eq('VISA')
        expect(ver.verify(Credit::Card.new(6, '4012888888881881', 'Jakub Nowak'))).to eq('VISA')
      end
    end
  end
end
