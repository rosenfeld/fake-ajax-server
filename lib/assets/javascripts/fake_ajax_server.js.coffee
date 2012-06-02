# =require jquery
# =require sinon

@FakeAjaxServer = class FakeAjaxServer
  constructor: (@fakeServerResponse, @imediateServe = false)->
  start: ->
    @ajaxCallbacksQueue = []
    @ajaxStub = sinon.stub $, 'ajax', @fakeAjax
  stop: -> $.ajax.restore()
  fakeAjax: =>
    responseStub = sinon.stub(new jQuery.Deferred)
    @ajaxCallbacksQueue.push [arguments, responseStub]
    @processAllRequests() if @imediateServe
    responseStub
  processNextRequest: -> @fakeServerResponse.apply this, @ajaxCallbacksQueue.shift()[0]
  processAllRequests: -> @processNextRequest() while @ajaxCallbacksQueue.length
  ignoreNextRequest: -> @ajaxCallbacksQueue.shift()
  ignoreAllRequests: -> @ajaxCallbacksQueue = []
  ajaxResponse: (index = 0)-> @ajaxCallbacksQueue[index][1]
  ajaxSettings: (index = 0)-> @ajaxCallbacksQueue[index][0][0]

