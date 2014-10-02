var CONFIG = require('config')
  , os = require('os')
  , restify = require('restify')
  , restifyOAuth2 = require('./lib/restify-oauth2')
  , mongoose = require('mongoose')
  , _ = require('lodash')
  ;


require('./models/user');
require('./models/access-token');

// HTTP Server
// ----------------------------------------------------------------------------
var server = restify.createServer( {
  name: 'sample-api',
  version: '0.1.0'
  /* https cert/key */
} );

server.use( [
    restify.queryParser()
    , restify.bodyParser( {
      maxBodySize: 0,
      uploadDir: os.tmpdir()
    })
    , restifyOAuth2.authorizationParser()
    , restify.CORS({
      origins: ['*'],
      headers: ['Authorization'],
      credentials: true
    })
  ]
);

var auth = require('./controllers/auth')
  , users = require('./controllers/users')
  , fileList = require('./controllers/file-list');
  ;

// Routes
// ----------------------------------------------------------------------------

// Echo
server.get('/echo', function( req, res, next ){
  res.send( req.params );
  next();
});

// User Auth
server.post('/api/register', auth.register);
server.post('/api/login', auth.login);
server.get('/api/logout', auth.logout );

// Health Check
server.get('/api/health-check', function( req, res, next ){
  mongoose.connection.db.command({ serverStatus: 1 }, function( err, result ){
    next.ifError( err );
    res.send( _.pick( result, ['host', 'version', 'uptime', 'network', 'ok']) );
    next();
  })
});

server.get('/api/files', fileList.listDirectory);

// ** Everything below here will require Auth Token **
server.use( restifyOAuth2.mustBeAuthorized() );

// Echo
server.get('/echo-auth', function( req, res, next ){
  res.send( req.params );
  next();
});

// Auth User Profile
server.get('/api/profile', function( req, res, next ){
  req.params.id = req.userId;
  next()
}, users.findOne );

// User Endpoint
server.get('/api/users/:id', users.findOne);
server.get('/api/users', users.search )

module.exports = server;
