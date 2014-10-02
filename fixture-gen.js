var fs = require('fs')
  , F = require('faker')
  , _ = require('lodash')
  , async = require( 'async')
  ;

var baseDir = __dirname + '/fixtures/'
async.each(_.range( 20 ), function( i ){
  fs.writeFile( baseDir + F.hacker.verb() + ".txt", "i", function( err ){
    if( err ) throw err;
  });
});
