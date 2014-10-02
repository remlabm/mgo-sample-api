chai = require 'chai'
chai.use( require 'chai-json-schema' )

authSchema =
  id: 'auth'
  type: 'object'
  required: [ 'token', 'expires']
  properties:
    token:
      type: 'string'
    expires:
      type: 'string'

userSchema =
  id: 'user'
  type: 'object'
  required: [ '_id', 'email', '__v' ]
  properties:
    _id:
      type: 'string'
    email:
      type: 'string'
    firstName:
      type: 'string'
    lastName:
      type: 'string'
    city:
      type: 'string'
    state:
      type: 'string'
    profession:
      type: 'string'
    __v:
      type: 'number'

usersSchema =
  id: 'users'
  type: 'array'
  items:
    $ref: 'user'

usersGroupedSchema =
  id: 'usersGrouped'
  type: 'array'
  items:
    type: 'object'
    required: ['_id', 'users']
    properties:
      _id:
        type: 'string'
      users:
        type: 'array'
        items:
          $ref: 'user'

# Register Schemas
chai.tv4.addSchema usersGroupedSchema
chai.tv4.addSchema usersSchema
chai.tv4.addSchema userSchema
chai.tv4.addSchema authSchema