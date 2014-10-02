var _ = require('lodash')
  fs = require('fs')
  ;

exports.listDirectory = function( req, res, next ){

  fs.readdir( __dirname + '/../../fixtures/', function( err, files ){
    next.ifError( err );
    res.send( files );
    next();
  });

};

