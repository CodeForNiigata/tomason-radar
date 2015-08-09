module.exports = (gulp) ->
  run = require 'run-sequence'

  gulp.task 'build', ['clean'], (callback) ->
    run ['copy', 'bower', 'compile'], ['inject'], callback
