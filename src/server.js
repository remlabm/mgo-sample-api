var CONFIG = require('config')
  , os = require('os')
  , restify = require('restify')
  , restifyOAuth2 = require('./lib/restify-oauth2')
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

// ** Everything below here will require Auth Token **
server.use( restifyOAuth2.mustBeAuthorized() );

// Echo
server.get('/echo-auth', function( req, res, next ){
  res.send( req.params );
  next();
});

module.exports = server;
