gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
mocha      = require 'gulp-mocha'
watch      = require 'gulp-watch'
yargs      = require 'yargs'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
browserify = require 'browserify'
source = require 'vinyl-source-stream'


handleError = (err) ->
  console.error err.message
  process.exit 1


gulp.task 'unit-test', ->
  gulp.src('tests/*-test.coffee', read: false)
    .pipe(mocha(reporter: 'spec', grep: yargs.argv.grep))
    .on 'error', handleError


gulp.task 'forgiving-unit-test', ->
  gulp.src('tests/*-test.coffee')
    .pipe(mocha(reporter: 'dot', compilers: 'coffee:coffee-script'))
    .on 'error', (err) ->
      if err.name is 'SyntaxError'
        console.error 'You have a syntax error in file: ', err if err
      @emit 'end'


gulp.task 'lint', ->
  gulp.src(['./*.coffee', './lib/*.coffee', './tests/*-test.coffee'])
    .pipe(coffeelint(opt: {max_line_length: {value: 1024, level: 'ignore'}}))
    .pipe(coffeelint.reporter())
    .pipe(coffeelint.reporter('fail'))
    .on 'error', -> process.exit 1


gulp.task 'forgiving-lint', ->
  gulp.src(['./*.coffee', './lib/*.coffee', './tests/*-test.coffee'])
    .pipe(coffeelint(opt: {max_line_length: {value: 1024, level: 'ignore'}}))
    .pipe(coffeelint.reporter())
    .on 'error', ->
      @emit 'end'


gulp.task 'compile-coffee', ->
  gulp.src './lib/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('js')
    .on 'error', ->
      @emit 'end'

###
gulp.task 'compile-js', ->
  compileFileName = 'resizer.min.js'
  gulp.src ['./js/*.js','./js/' + compileFileName]
    .pipe concat(compileFileName)
    .pipe uglify(preserveComments:'some')
    .pipe gulp.dest('./js/')
    .on 'error', ->
      @emit 'end'
gulp.task 'compile-js', ->
  browserify
    entries: ['./js/resizer.js','./js/image-rgba.js']
    standalone: 'noscope'
  .bundle()
  .pipe source 'resizer.min.js'
  .pipe gulp.dest "./js/"
###
gulp.task 'compile-js', ->
  browserify
    entries: ['./lib/image-rgba.coffee','./lib/resizer.coffee']
    extensions: ['.coffee', '.js']
  .transform 'coffeeify'
  .bundle()
  .pipe source 'resizer.min.js'
  .pipe gulp.dest 'js'

gulp.task 'test', ['compile-coffee','unit-test','lint']


gulp.task 'tdd', ->
  gulp.watch 'lib/*.coffee', ['forgiving-lint', 'forgiving-unit-test']
  gulp.watch 'tests/*-test.coffee', ['forgiving-lint', 'forgiving-unit-test']


gulp.task 'default', ['test']
gulp.task 'compile', ['compile-coffee','compile-js']


return
