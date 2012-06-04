# =require jquery
# =require sinon

@FakeAjaxServer = class FakeAjaxServer
  constructor: (@fakeServerResponse, @options = {})->
  start: ->
    @ajaxCallbacksQueue = []
    @ajaxStub = sinon.stub jQuery, 'ajax', @fakeAjax
  stop: -> jQuery.ajax.restore()
  fakeAjax: =>
    responseStub = @createFakeJqXHR()
    @ajaxCallbacksQueue.push [arguments, responseStub]
    @processAllRequests() if @options.imediateServe
    responseStub
  processNextRequest: -> @fakeServerResponse.apply this, @ajaxCallbacksQueue.shift()[0]
  processAllRequests: -> @processNextRequest() while @ajaxCallbacksQueue.length
  ignoreNextRequest: -> @ajaxCallbacksQueue.shift()
  ignoreAllRequests: -> @ajaxCallbacksQueue = []
  ajaxResponse: (index = 0)-> @ajaxCallbacksQueue[index][1]
  ajaxSettings: (index = 0)-> @ajaxCallbacksQueue[index][0][0]

  createFakeJqXHR: ->
    xhr = jQuery.Deferred()
    (xhr[m] = (->) for m in ['error', 'success', 'complete']) if @options.legacySupport
    sinon.stub xhr, m, (-> xhr) for m, f of xhr when typeof f is 'function'
    xhr
