# frozen_string_literal: true
require 'credit/card'
require 'credit/verificator'
require 'credit/version'

module Credit
  class Error < StandardError; end

  class CodeSyntaxError < StandardError
    def message
      'Code should not cointain any alphabets chars'
    end
  end

  class Main
    def self.run
      ver = Credit::CardVerificator.new
      puts ver.verify(Credit::Card.new(1, '1234567890', 'Jakub Nowak'))
    end
  end
end

Credit::Main.run
