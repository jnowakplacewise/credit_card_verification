# frozen_string_literal: true

module Credit
  class Card
    attr_accessor :id, :code, :owner

    def initialize(id, code, owner)
      @id = id
      @code = code
      @owner = owner
    end

    def to_s
      "ID: #{@id.to_i}, CODE: #{@code}, OWNER: #{@owner}"
    end
  end
end
