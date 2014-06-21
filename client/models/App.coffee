#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  newHand: ->
    console.log('reload')
    window.location.reload(true)
    # if @get('deck').size() > 12
    #   @set 'playerHand', @get('deck').dealPlayer()
    #   @set 'dealerHand', @get('deck').dealDealer()
    #   console.dir(@get('deck').size())
    # else
    #   @initialize()
    #   console.log('else')
    #   console.dir(@get('deck').size())


