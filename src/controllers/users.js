var mongoose = require('mongoose')
  , _ = require('lodash')
  , User = mongoose.model('User')
  ;

var userPublic = ['email', 'firstName', 'city', 'state', 'profession', 'createdAt', '__v'];

// ## Get User
exports.findOne = function (req, res, next) {
  User.findOne({ _id: req.params.id }, '-password', function (err, profile) {
    next.ifError( err );
    res.send( profile );
    return next()
  })
};

// ## Search Users
exports.search = function( req, res, next ){
  var userPipe = User.aggregate()
    .project( userPublic.join(' ') )
    ;

  // handle pagination
  req.query.skip = parseInt( req.query.skip );
  if( _.isNaN( req.query.skip ) || req.query.skip <= 1 ){
    req.query.skip = 0;
  }
  req.query.limit = parseInt( req.query.limit );
  if( _.isNaN( req.query.limit ) || req.query.limit > 100 ){
    req.query.limit = 100;
  }

  // handle filters and matching
  if( req.query.filter ){
    req.query.filter = JSON.parse( req.query.filter );
    userPipe.match( req.query.filter );
  }

  // handle group by
  if( req.query.group ){
    userPipe.group( { _id : "$" + req.query.group, users: { $push: "$$ROOT" }} );
  }

  // finish and pipe response
  userPipe
    .skip( req.query.skip )
    .limit( req.query.limit )
    .exec( function( err, users ){
      next.ifError( err );
      res.send( users );
      next();
    });
};