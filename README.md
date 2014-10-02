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

## How to use locally
1. Clone repo `git clone git@github.com`
2. Run `npm install`
3. Start service `gulp`

## How to test **Requires mocha
Run `npm test`

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

#### User Register: [POST] `/api/register`
Payload: 
```js
{"email":"testing123@test.com","password":"test123"}`
```
Response
```js
{"__v":0,"_userId":"542db426777371faf368df6f", ... "token":"c69ebc68cc76097ed300f8158f5434f6"}
```
**Use TOKEN for Bearer Auth Header**


#### User Login: [POST] `/api/login`
Payload
```js
{"login":"testing123@test.com","password":"test123"}
```
Response
```js
{"__v":0,"_userId":"542db426777371faf368df6f", ... "token":"c69ebc68cc76097ed300f8158f5434f6"}
```
**Use TOKEN for Bearer Auth Header**

#### Users List: [GET] `/api/users`

#### Health Check: [GET]: `/api/health-check`
Response
```js
{"host":"rmac.local","version":"2.6.1","uptime":528604,"network":{"bytesIn":17910206,"bytesOut":12352015,"numRequests":28406},"ok":1}
```

#### File List [GET]: /api/files
Response: `// File Array`

#### Sample Queries
* Get Users filtering managers: `/api/users?filter={"profession":"Manager"}`
* Get Users grouped by profession: `/api/users?group=profession`
* Get 20 users skipping first 5: `/api/users?limit=20&skip=5`

## TODO
  - n/a
