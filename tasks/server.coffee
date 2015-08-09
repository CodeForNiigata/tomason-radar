module.exports = (gulp) ->
  watch = require 'gulp-watch'
  webserver = require 'gulp-webserver'

  gulp.task 'watch', ->
    targets = [
      'src/html/**/*.haml'
      'src/html/**/*.html'
      'src/css/**/*.scss'
      'src/css/**/*.css'
      'src/js/**/*.coffee'
      'src/js/**/*.js'
    ]
    gulp.watch targets, ['build']

  gulp.task 'server', ['build'], ->
    gulp.src 'build'
      .pipe webserver
        livereload: true
        open: true
