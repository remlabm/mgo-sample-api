
describe 'Heath Check Endpoint', ->

  it 'should return application usage data', (done)->
    client.get "/api/health-check", ( err, req, res, obj )->
      assert.ifError err
      assert.jsonSchema( obj, chai.tv4.getSchema 'healthCheck')
      done()