class window.Deck extends Backbone.Collection


  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
    # @set('dealerHand', )
    # @set('playerHand', )

  dealPlayer: -> new Hand [ @pop(), @pop() ], @
    # @get('playerHand')

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
    # dHand = @get('dealerHand')
    # pHand = @get('playerHand')
    # hasAce = dHand.reduce (memo, card) ->
    #   memo or card.get('value') is 1
    # , false
    # score = dHand.reduce (score, card) ->
    #   score +  card.get('value')
    # , 0
    # if score + 10 == 21 and pHand.bestScore() == 21 then @trigger('TIE', @)
    # if score + 10 == 21 and pHand.bestScore() < 21 then pHand.trigger('busted', @)
    # if score + 10 < 21 and pHand.bestScore() == 21 then dHand.trigger('busted', @)
    # dHand

