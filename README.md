# FakeAjaxServer

Fake your AJAX jQuery requests with Sinon.js and stub the responses in your tests/specs.

## Installation

Add this line to your application's Gemfile:

    gem 'fake-ajax-server', group: [:development, :test]

And then execute:

    $ bundle

Feel free to use it outside of Rails applications as well. Just grab the source at lib/assets/javascripts.

## Usage

```coffeescript
# =require fake_ajax_server

fakeAjaxServer = new FakeAjaxServer (url, settings)=>
  if settings then settings.url = url else settings = url
  handled = false
  switch settings.dataType
    when 'json' then switch settings.type
      when 'get' then switch settings.url
        when '/products' then handled = true; settings.success [
            {id: 1, name: 'Guitar'}
            {id: 2, name: 'Flute'}
        ]
      when 'post' then switch settings.url
        when '/products' then handled = true; settings.success id: 3, name: settings.data.name
    when undefined then switch settings.type
      when 'post' then switch settings.url
        when '/products/1/delete' then handled = true; settings.success()
  return if handled
  console.log arguments
  throw "Unexpected AJAX call: #{settings.url}"

fakeAjaxServer.start()
$.getJSON '/products', (data)-> console.log data
expect(fakeAjaxServer.ajaxSettings().url).toBe '/products'/products
fakeAjaxServer.processNextRequest()
$.post '/products', name: 'Drums', ((data)-> console.log data.id), 'json'
failed = false
$.post('/products/1/delete').fail -> failed = true

expect(fakeAjaxServer.ajaxSettings(0).data.name).toBe 'Drums' # 0 is used by default
expect(fakeAjaxServer.ajaxSettings(1).url).toBe '/products/1/delete'
expect(fakeAjaxServer.ajaxResponse(1).fail).not.toBeUndefined()
fakeAjaxServer.ajaxResponse(1).fail()
expect(failed).toBe true
fakeAjaxServer.ignoreNextRequest() # ignores POST '/products'
# alternatively use fakeAjaxServer.ignoreAllRequests()
fakeAjaxServer.processAllRequests() # would be the same as processNextRequest in this case

fakeAjaxServer.stop() # undo $.ajax stubbing, restoring the original method
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
