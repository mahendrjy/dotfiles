// Load plugins
const gulp = require('gulp');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');
const postcss = require('gulp-postcss');
const rename = require('gulp-rename');
const sass = require('gulp-sass');
const sourcemaps = require('gulp-sourcemaps');
const eslint = require('gulp-eslint');
const webpack = require('webpack');
const webpackconfig = require('./webpack.config.js');
const webpackstream = require('webpack-stream');
const browsersync = require('browser-sync').create();
const del = require('del');
const imagemin = require('gulp-imagemin');
const cache = require('gulp-cache');
const gulpHtmlmin = require('gulp-htmlmin');

// BrowserSync
// Live reload with BrowserSync
function init(done) {
  browsersync.init({
    server: {
      baseDir: './dist/',
    },
    files: ['./dist/css/style.min.css', './dist/js/**/*', './dist/**/*.html'],
    port: 3000,
    open: false,
  });
  done();
}

// ------------ Development Tasks -------------
// Copies html to dist
function html() {
  return gulp
    .src('./src/**/*.html')
    .pipe(gulpHtmlmin({ collapseWhitespace: true }))
    .pipe(gulp.dest('./dist/'));
}

// Compile Sass into CSS
function cssBuild() {
  return gulp
    .src('./src/scss/**/*.scss')
    .pipe(sourcemaps.init())
    .pipe(
      sass({
        outputStyle: 'expanded',
        sourceComments: 'map',
        sourceMap: 'sass',
        outputStyle: 'nested',
      }).on('error', sass.logError)
    )
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./dist/css/'))
    .pipe(rename({ suffix: '.min' }))
    .pipe(
      postcss([
        autoprefixer(),
        cssnano(), // Use cssnano to minify CSS
      ])
    )
    .pipe(gulp.dest('./dist/css/'));
}

// Lint scripts
function jsLint() {
  return gulp
    .src(['./src/js/main.js'])
    .pipe(eslint())
    .pipe(eslint.format())
    .pipe(eslint.failAfterError());
}

// Transpile, concatenate and minify scripts
function jsBuild() {
  return (
    gulp
      .src(['./src/js/**/*'])
      .pipe(webpackstream(webpackconfig, webpack))
      // folder only, filename is specified in webpack
      .pipe(gulp.dest('./dist/js/'))
  );
}

// ------------ Optimization Tasks -------------
// Copies image files to dist
function imgOptimise() {
  return gulp
    .src('./src/assets/img/**/*.+(png|jpg|jpeg|gif|svg)')
    .pipe(
      cache(
        imagemin([
          imagemin.gifsicle({ interlaced: true }),
          imagemin.jpegtran({ progressive: true }),
          imagemin.optipng({ optimizationLevel: 5 }),
          imagemin.svgo({
            plugins: [
              {
                removeViewBox: false,
                collapseGroups: true,
              },
            ],
          }),
        ])
      )
    ) // Caching images that ran through imagemin
    .pipe(gulp.dest('./dist/assets/img/'));
}

// Copies video assets to dist
function media() {
  return gulp
    .src('src/assets/videois/**/*')
    .pipe(gulp.dest('dist/assets/videos/'));
}

// Copy fonts
function fontsCopy() {
  return gulp
    .src('./src/assets/fonts/**/*')
    .pipe(gulp.dest('./dist/assets/fonts/'));
}

// Watch files for changes while gulp is running
function watchFiles() {
  gulp.watch('./src/scss/**/*', cssBuild);
  gulp.watch('./src/js/**/*', scripts);
  gulp.watch('./src/**/*', html);
  gulp.watch('./src/assets/img/**/*', imgOptimise);
  gulp.watch('./src/assets/videos/**/*', media);
  gulp.watch('./src/assets/fonts/**/*', fontsCopy);
}

// Cleaning/deleting files no longer being used in dist folder
function clean() {
  console.log('Removing old files from dist');
  return del(['./dist/']);
}

// define complex tasks
const scripts = gulp.series(jsLint, jsBuild);
const images = gulp.series(imgOptimise);
const watch = gulp.parallel(watchFiles, init);
const build = gulp.series(
  clean,
  gulp.parallel(fontsCopy, cssBuild, images, scripts, html, media)
);

// expose tasks to CLI
exports.build = build;
exports.watch = watch;
exports.default = build;
