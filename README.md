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

### Versioning

### Endpoint Definitions


## How to use local development
1. Clone repo `git clone git@github.com`
2. Run `npm install`
3. Start service `gulp`

## Test * Requires mocha
Run `npm test`

## How to deploy

## TODO
  - n/a