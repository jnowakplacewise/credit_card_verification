
require_relative '../credit/version'
require_relative '../credit/card'
require_relative '../credit/verificator'

module Credit
    class Error < StandardError; end

    class Main
        def Main.run
            ver = Credit::CardVerificator.new
            ver.verify(Credit::Card.new(1, "4003600000000014", "Jakub Nowak"))
        end
    end
end


Credit::Main.run