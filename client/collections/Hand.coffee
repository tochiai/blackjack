class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on('hitted', (hand)->
      if hand.scores()[0] > 21 then @busted()
      0
    )


  hit: ->
    @add(@deck.pop()).last()
    @trigger('hitted', @)
    console.log(@)

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
  busted: ->
    @trigger('busted', @)

  stand: ->
    @trigger('dealer', @)

  dealerPlay: ->
    checkCards = (card) ->
      if !card.get 'revealed' then card.flip()
    @each(checkCards)
    array = @scores()
    if array.length == 1
      while array[0] < 17 and array.length == 1
        @hit()
        array = @scores()
      if array.length == 2
        while array[1] < 18
          @hit()
          array = @scores()
        if array[1] > 21
          while array[0] < 17
            @hit()
            array = @scores()
    else
      while array[1] < 18
        @hit()
        array = @scores()
      if array[1] > 21
        while array[0] < 17
          @hit()
          array = @scores()
    @trigger('endHand', @)

  bestScore: ->
    arr = @scores()
    if arr.length == 1
      return arr[0]
    else
      if arr[1] > 21
        return arr[0]
      else
        return arr[1]








