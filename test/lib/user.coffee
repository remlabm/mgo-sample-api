async = require 'async'
_ = require 'lodash'
F = require 'faker'
restify = require 'restify'
qs = require 'querystring'
professions = [ 'Manager', 'Engineer', 'Director', 'QA', 'Systems' ]


module.exports = class User

  defaults:
    client:
      url: 'http://localhost:8081'

  constructor: ( userData, options )->
    @setOptions options

    if _.isString userData
      @fakeUserData { firstName: userData }
    else
      @fakeUserData userData

    @client = restify.createJsonClient @options.client

  setOptions: (options) ->
    @options = _.merge @defaults, options
    this

  fakeUserData: ( userData ) ->
    @userData = _.merge {
      email: F.internet.email()
      password: 'test123'
      firstName: F.name.firstName()
      lastName: F.name.lastName()
      city: F.address.city()
      state: F.address.stateAbbr()
      profession: F.random.array_element( professions )
    }, userData


  login: ( done )->
    @client.post '/api/login', { login: @userData.email, password: @userData.password }, ( err, req, res, auth)=>
      if( err )
        done( err )
      @auth = auth
      @setToken auth.token
      done( null, auth )

  register: ( done )->
    @client.post '/api/register', @userData, ( err, req, res, auth )=>
      if( err )
        done( err )
      @auth = auth
      @setToken auth.token
      done( null, auth )

  setHeaders: ( headers )->
    @client.headers = _.merge( @client.headers, headers )

  setToken: ( token )->
    @setHeaders { Authorization: "Bearer #{token}" }

  @setup: ( userData, options, done )->
    user = new @( userData, options)

    user.register (err)->
      if err
        done err

      done null, user
