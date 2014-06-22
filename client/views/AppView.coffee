class window.AppView extends Backbone.View
  bustedHand = false

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="next-button">Next Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .next-button": -> @model.newHand(); @render()

  initialize: ->
    @model.get('playerHand').on('busted', -> $('.hit-button, .stand-button').attr('disabled', true))
    @model.get('playerHand').on('dealer', -> $('.hit-button, .stand-button').attr('disabled', true))
    @model.get('playerHand').on('dealer', => @model.get('dealerHand').dealerPlay())
    @model.get('playerHand').on('busted', -> $('.player-hand-container h2').append('<span>--YOU BUSTED</span>'))
    @model.get('dealerHand').on('busted', -> $('.player-hand-container h2').append('<span>--YOU WIN!!!</span>'))
    @model.get('playerHand').on('busted', => @set('bustedHand', true))
    @model.get('dealerHand').on('busted', => @set('bustedHand', true))
    @model.get('dealerHand').on('endHand', => console.log('ended'))
    @model.get('dealerHand').on('endHand', -> if @get('bustedHand') == false then @checkWinner())

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkWinner: ->
    pScore = @model.get('playerHand').bestScore()
    dScore = @model.get('dealerHand').bestScore()
    if pScore > dScore
      $('.player-hand-container h2').append('<span>--YOU WIN!!!</span>')
    else
      $('.player-hand-container h2').append('<span>--YOU LOST!!!</span>')
