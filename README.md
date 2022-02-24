# credit_card_verification
The library aim is to provide functionality to check whenever
credit card is valid.

### Card
```code
class Card
    attr_accessor :id, :code, :owner

    def initialize(id, code, owner)
      @id = id
      @code = code
      @owner = owner
    end
```

Card is a class which take 3 parameters, id, code and owner.
Now the most important is code field, becouse it is exactly on what
the Validator class will be operating.

### Verificator
```code
class Verificator
  ...
  def verify(card)
    code = clean_code(card.code).to_s
      if check_alpha(code) && check_prefix(code) && check_length(code) && check_code_with_luhn(code).to_s
        get_provider(code)
      else
        'INVALID'
      end
  end
```

### Manual
1. Create Verificator Object
2. Call verify method with Card Object 
3. Card object should take id - int, code - string and owner - string
```code
ver = Credit::CardVerificator.new
ver.verify(Credit::Card.new(1, '1234567890', 'Jakub Nowak'))
```

### Installation
1. Download file credit_card_verification-0.0.0.gem
2. Run ```gem install ./credit_card_verification-0.0.0.gem```
3. ```require 'credit/card'```
 ```require 'credit/verificator```
