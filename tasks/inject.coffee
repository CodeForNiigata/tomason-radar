module.exports = (gulp) ->
  inject = require 'gulp-inject'
  run = require 'run-sequence'

  doInject = (srcs, name) ->
    starttag = "<!-- inject:#{name}:{{ext}} -->"
    endtag = "<!-- endinject -->"

    injections = gulp.src srcs, {read: false}
    options =
      starttag: starttag
      endtag: endtag
      relative: true

    gulp.src 'build/**/*.html'
      .pipe inject injections, options
      .pipe gulp.dest 'build'

  gulp.task 'inject', (callback) ->
    run 'inject:components', 'inject:main', callback

  gulp.task 'inject:components', ->
    srcs = [
      'build/css/components.css'
      'build/js/components.js'
    ]
    doInject(srcs, 'components')

  gulp.task 'inject:main', ->
    srcs = [
      'build/css/style.css'
      'build/js/script.js'
    ]
    doInject(srcs, 'main')
