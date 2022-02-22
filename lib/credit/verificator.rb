# frozen_string_literal: true

require_relative './card'

module Credit
  class Verificator
    def verify(card); end
  end

  class CardVerificator < Verificator
    def get_provider(code)
      providers = {
        'AMEX' => [34, 37],
        'MASTERCARD' => [51, 52, 53, 54, 55],
        'VISA' => [4]
      }
      code_prefix = code[0].to_i == 4 ? code[0] : code[0..1]
      providers.select { |_k, v| v.include? code_prefix.to_i }.keys
    end

    def clean_code(code)
      code.gsub(/-/, '')
    end

    def check_alpha(code)
      code.match(/\D/) ? false : true
    end

    def check_prefix(code)
      provider = get_provider(code)
      provider.nil? ? false : true
    end

    def check_length(code)
      providers_lengths = {
        'AMEX' => [15],
        'MASTERCARD' => [16],
        'VISA' => [13, 16]
      }
      provider = get_provider(code)
      
      begin
        providers_lengths[provider[0]].include? code.length
      rescue NoMethodError
        false
      end
    end

    def check_code_with_luhn(code)
      last = code[-1]
      code = code[0...-1]
      even_sum = 0
      odd_sum = 0

      code.split('').map(&:to_i).reverse.each_with_index do |val, i|
        val *= 2 if i.even?
        even_sum += val > 10 ? 1 + (val % 10) : val if i.even?
        odd_sum += val if i.odd?
      end
      ((even_sum + odd_sum + last.to_i) % 10).zero?
    end

    def verify(card)
      code = clean_code(card.code).to_s
      puts "CODE: #{code}"
      if check_alpha(code) && check_prefix(code) && check_length(code) && check_code_with_luhn(code).to_s
        puts 'ALL INITIAL CHECKS ARE OK'
        get_provider(code)
      else
        'INVALID'
      end
    end
  end
end
