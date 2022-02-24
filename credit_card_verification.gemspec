# frozen_string_literal: true

Gem::Specification.new do |s|
    s.name        = 'credit_card_verification'
    s.version     = '0.0.0'
    s.summary     = "verification"
    s.description = "verificaion of credit card code"
    s.authors     = ["Jakub Nowak"]
    s.email       = 'jakub.nowak@placewise.com'
    s.files = [
        'lib/credit/card.rb',
        'lib/credit/verificator.rb',
        'lib/credit/version.rb',
        'lib/error/error.rb'
      ]
    s.license       = 'MIT'
  end