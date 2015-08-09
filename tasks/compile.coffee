module.exports = (gulp) ->
  haml = require 'gulp-haml'
  sass = require 'gulp-sass'
  coffee = require 'gulp-coffee'

  plumber = require 'gulp-plumber'
  minify = require 'gulp-minify-css'
  uglify = require 'gulp-uglify'
  concat = require 'gulp-concat'

  gulp.task 'compile', ['haml', 'sass', 'coffee'], ->

  gulp.task 'haml', ->
    gulp.src 'src/html/**/*.haml'
      .pipe plumber()
      .pipe haml()
      .pipe plumber.stop()
      .pipe gulp.dest('build')

  gulp.task 'sass', ->
    gulp.src 'src/css/**/*.scss'
      .pipe plumber()
      .pipe sass()
      .pipe concat('style.css')
      .pipe minify()
      .pipe plumber.stop()
      .pipe gulp.dest('build/css')

  gulp.task 'coffee', ->
    gulp.src 'src/js/**/*.coffee'
      .pipe plumber()
      .pipe coffee()
      .pipe concat('script.js')
      .pipe uglify()
      .pipe plumber.stop()
      .pipe gulp.dest('build/js')
