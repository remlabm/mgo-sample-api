User = require './lib/user'
Users = require './lib/users'

describe 'Users Endpoint', ->

  before ( done )->
    @user = new User(
      email: 'test1@test.com'
      password: 'test123'
      firstName: 'John'
      lastName: 'Smith'
      city: 'Los Angeles'
      state: 'CA'
      profession: 'Being Awesome'
    )
    done()

  describe 'Profile Data Tests', ->

    userId = null

    it 'should register a new user with profile data and return a token', ( done ) ->
      @user.register ( err, obj )->
        assert.isNull err
        assert.jsonSchema( obj, chai.tv4.getSchema 'auth')
        userId = obj._userId
        done()

    it 'should return authenticated users profile data', ( done ) ->
      @user.client.get '/api/profile', ( err, req, res, profile ) ->
        assert.ifError err
        assert.jsonSchema( profile, chai.tv4.getSchema 'user' )
        done()

  describe 'Single User Filter Test', ->

    before (done)->
      Users.setup ['Jim', 'Jill', 'Steve', 'Sarah'], ( err, users )=>
        @users = users
        done()

    it 'should return list of created users', (done)->
      @user.client.get '/api/users', ( err, req, res, users )->
        assert.ifError err
        assert.jsonSchema( users, chai.tv4.getSchema 'users')
        done()

    it 'should return Jill when filtering by firstName', (done)->
      filterQuery = {
        firstName: 'Jill'
      }
      @user.client.get "/api/users?filter=#{JSON.stringify( filterQuery )}", ( err, req, res, users )->
        assert.ifError err
        assert.jsonSchema( users, chai.tv4.getSchema 'users')
        assert.lengthOf users, 1
        assert.equal users[0].firstName, 'Jill'
        done()

  describe 'Multiple User Filter Test', ->

    before (done)->
      Users.setup _.range( 20 ), ( err, users )->
        @users = users
        done()

    it 'should return all managers when filtering by profession', (done)->
      filterQuery = {
        profession: 'Manager'
      }
      @user.client.get "/api/users?filter=#{JSON.stringify( filterQuery )}", ( err, req, res, users )->
        assert.ifError err
        assert.jsonSchema( users, chai.tv4.getSchema 'users')
        done()

    it 'should return all engineers and systems when filtering by profession', (done)->
      filterQuery = {
        profession: {
          '$in': ['Manager', 'Systems']
        }
      }
      @user.client.get "/api/users?filter=#{JSON.stringify( filterQuery )}", ( err, req, res, users )->
        assert.ifError err
        assert.jsonSchema( users, chai.tv4.getSchema 'users')
        done()

  describe 'Multiple User Group Test', ->

    it 'should return all users grouped by profession', ( done )->
      @user.client.get '/api/users?group=profession', ( err, req, res, users )->
        assert.ifError err
        assert.jsonSchema( users, chai.tv4.getSchema 'usersGrouped' )
        done()


  describe 'Pagination Tests', ->
    totalUsers = null
    limitedUsers = null

    it 'should return all of the users', ( done )->
      @user.client.get "/api/users", ( err, req, res, users )->
        assert.ifError err
        totalUsers = users.length
        done()

    it 'should return 10 users', ( done )->
      @user.client.get "/api/users?limit=10", (err, req, res, users )->
        assert.ifError err
        assert.equal users.length, 10
        limitedUsers = users
        done()

    it 'should skip 10 users and return 10 more', ( done )->
      @user.client.get "/api/users?limit=10&skip=10", ( err, req, res, users )->
        assert.ifError err
        assert.equal users.length, 10
        assert.notDeepEqual users, limitedUsers
        done()
