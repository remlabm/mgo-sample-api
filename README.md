# MGO Interview Api 
Sample Api application demonstrating CRUD with OAuth2 

## Requirements
1) Build a small app that consists of 4 endpoints.
  - Build an endpoint that authenticates a user based on a login/password passed in a JSON payload and verifies against a simple data structure (Mongo, MySQL, etc.).
  - Build an endpoint that returns all users in the database filtered by a URL parameter (can be city, profession, etc) and groups them by another parameter (also your choice).
  - Build an endpoint that checks and returns the status of all components that it depends on (e.g. Is Mongo still up OK, etc.).
  - Build an endpoint that when called returns the list of files in a given directory.

2) Deliverables
  - Source code + deployment instructions

3) Things to consider for your "readme" doc.
  - Use the technologies of your choice but please add a small paragraph on why you choose that technology.
  - The endpoints have to be able to handle versioning, please explain the strategy on how to accomplish this.
  - If you have time please add pagination, if not please describe how the solution would support pagination
  - The application should compile and execute correctly.
  - Please make sure that you have Unit Tests.

### Technologies
Requirements: 
  - NodeJS 10.24+
  - MongoDB 2.6+
  
List of main libraries being used:
- [Restify](http://mcavage.me/node-restify/): Slim wrapper for handling API. Includes useful tools for handling errors and versioning.
- [MongooseJS](http://mongoosejs.com/index.html): Modeling library for MongoDB.
- [LoDash](http://lodash.com/): Utility library, similar to underscore.

### Versioning
Versioning of the endpoints can be handled by Restify library. Example: If we moved files listings to an updated version.
```js
server.get('/api/files', version: '0.0.2'}, function( req, res, next ){ ... });
```

When a client passes a version header, will be handled accordingly. This also allows deprecation responses for clients that have not updated.
```js
server.get('/api/files', version: '0.0.1'}, handleDeprecated, function( req, res, next ){ ... });
```

### Endpoint Definitions
#### oAuth
  - Register
  -- Method: Post
  -- Path: `/api/register`
  -- Payload: `{"email":"testing123@test.com","password":"test123"}`


## How to use locally
1. Clone repo `git clone git@github.com`
2. Run `npm install`
3. Start service `gulp`

## How to test **Requires mocha
Run `npm test`

## TODO
  - n/a