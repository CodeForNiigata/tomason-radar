module.exports = (gulp) ->
  bower = require 'main-bower-files'

  concat = require 'gulp-concat'
  minify = require 'gulp-minify-css'
  uglify = require 'gulp-uglify'
  run = require 'run-sequence'

  overrides = {}

  gulp.task 'bower', (callback) ->
    run ['bower:js', 'bower:css', 'bower:img', 'bower:fonts'], callback

  gulp.task 'bower:js', () ->
    jsOptions =
      "overrides": overrides
      "filter": "**/*.js"
    gulp.src bower(jsOptions)
      .pipe concat('components.js')
      .pipe uglify()
      .pipe gulp.dest('build/js')

  gulp.task 'bower:css', () ->
    cssOptions =
      "overrides": overrides
      "filter": [
        "**/*.css"
      ]
    gulp.src bower(cssOptions)
      .pipe concat('components.css')
      .pipe minify()
      .pipe gulp.dest('build/css')

  gulp.task 'bower:img', () ->
    imgOptions =
      "overrides": overrides
      "filter": [
          "**/*.gif"
          "**/*.jpg"
          "**/*.png"
        ]
    gulp.src bower(imgOptions)
      .pipe gulp.dest('build/css')

  gulp.task 'bower:fonts', () ->
    fontsOptions =
      "overrides": overrides
      "filter": [
          "**/*.eot"
          "**/*.svg"
          "**/*.ttf"
          "**/*.woff"
          "**/*.woff2"
        ]
    gulp.src bower(fontsOptions)
      .pipe gulp.dest('build/fonts')
