
require_relative '../credit/version'
require_relative '../credit/card'
require_relative '../credit/verificator'

module Credit
    class Error < StandardError; end

    class Main
        def Main.run
            ver = Credit::CardVerificator.new
            puts ver.verify(Credit::Card.new(1, "1234567890", "Jakub Nowak"))
        end
    end
end


Credit::Main.run