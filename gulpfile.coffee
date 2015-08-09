gulp = require 'gulp'
run = require 'run-sequence'

require('./tasks/compile')(gulp)
require('./tasks/bower')(gulp)
require('./tasks/build')(gulp)
require('./tasks/files')(gulp)
require('./tasks/inject')(gulp)
require('./tasks/server')(gulp)

gulp.task 'default', (callback) ->
  run 'watch', 'server', callback
