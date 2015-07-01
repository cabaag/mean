gulp          = require 'gulp'
gutil         = require 'gulp-util'
watch         = require 'gulp-watch'
sourcemaps    = require 'gulp-sourcemaps'

jade          = require 'gulp-jade'

coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
uglify        = require 'gulp-uglify'

sass          = require 'gulp-sass'
minifyCss     = require 'gulp-minify-css'
rename        = require 'gulp-rename'

paths = {
  app: [
    './www/**/*.js'
    './www/**/*.css'
    './www/*.jade'
    './www/views/*.jade'
    './www/views/**/*.jade'
    './www/images/*.*'
    './www/images/**/*.*'
    './www/index.html'
  ]

  config: './dev/config/main.coffee'
  images: [
    './dev/images/*.*'
    './dev/images/**/*.*'
  ]
  lib: [
    './dev/lib/**'
  ]
  scripts: [
    './dev/coffee/*.coffee'
    './dev/coffee/**/*.coffee'
    ]
  scripts_dst: './www/public/js/'
  styles: [
    './dev/sass/*.scss'
    './dev/sass/**/*.scss'
  ]
  styles_dst: './www/public/css/'
  views: [
    './dev/views/*.jade'
    './dev/views/**/*.jade'
  ]
  views_dst: './www/views/'
}

gulp.task 'copy-images', ->
  watch paths.images, ->
    console.log "Copiando imagenes"
    gulp.src paths.images
      .pipe gulp.dest('./www/public/img')
      .pipe watch paths.images
  return

gulp.task 'copy-lib', ->
  watch paths.lib, ->
    console.log "Copiando librerias"
    gulp.src paths.lib
      .pipe gulp.dest('www/public/lib')
      .pipe watch paths.lib
  return

gulp.task 'build-config', ->
  watch paths.config, ->
    console.log "Configurando"
    gulp.src paths.config
      .pipe gulp.dest('./www/public/config')
      .pipe watch paths.config
   return

gulp.task 'jade', ->
  watch paths.views, ->
    console.log "Copiando jade"
    gulp.src paths.views
      .pipe gulp.dest(paths.views_dst)
      .pipe watch paths.views
   return

gulp.task 'sass', ->
  watch paths.styles, ->
    console.log "Compilando sass"
    gulp.src paths.styles
      .pipe sourcemaps.init()
        .pipe sass()
          .on 'error', gutil.log
        # .pipe minifyCss()
        # .pipe rename extname: '.min.css'
        # .pipe gulp.dest paths.styles_dst
        # .pipe watch paths.styles
      .pipe sourcemaps.write('.')
      .pipe gulp.dest paths.styles_dst
   return

gulp.task 'coffee', ->
  watch paths.scripts, ->
    console.log "Compilando coffe"
    gulp.src paths.scripts
      .pipe coffee
        bare: true
      .on 'error', gutil.log
      .pipe concat('main.js')
      .pipe gulp.dest paths.scripts_dst
      .pipe uglify()
      .pipe rename extname: '.min.js'
      .pipe gulp.dest paths.scripts_dst
      .pipe watch paths.scripts
   return

gulp.task 'express', ->
  server = require('./server.coffee')()

module.exports =
  gulp.task 'default', [
    'build-config'
    'copy-images'
    'copy-lib'
    'jade'
    'sass'
    'coffee'
    'express'
  ]
