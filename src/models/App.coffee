# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @on 'all', alert, @
    # @get 'hand'.on 'bust', alert @get 'hand'
    playerHand = @get 'playerHand'
    playerHand.on 'bust', @bust, @
    playerHand.on 'stand', @playDealer, @

  bust: ->
    alert 'bust'
    @redeal()

  playDealer: ->
    console.log 'dealer turn'
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    dealerHand.first().flip()

    while dealerHand.scores()[1] < 17
      dealerHand.hit()

    if playerHand.maxScore() > dealerHand.maxScore() or dealerHand.minScore() > 21
      alert('You win!')
    else
      alert('Dealer wins!')

    @redeal()

  redeal: ->
    deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    playerHand.on 'bust', @bust, @
    playerHand.on 'stand', @playDealer, @    
    @trigger 'redeal', @