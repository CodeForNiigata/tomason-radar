module.exports = (gulp) ->
  del = require 'del'

  gulp.task 'clean', (cb) ->
    del ['build'], cb

  gulp.task 'copy', ->
    srcs = [
      'src/css/**/*.css'
      'src/data/**/*'
      'src/fonts/**/*'
      'src/img/**/*'
      'src/js/**/*.js'
    ]
    gulp.src srcs, {base: 'src'}
      .pipe gulp.dest 'build'
