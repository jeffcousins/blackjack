assert = chai.assert

describe 'app', ->
  app = null
  beforeEach ->
    app = new App()
    
  it 'should deal new hands', ->
    debugger