import gulp from 'gulp';
import gulpIf from 'gulp-if';
import plumber from 'gulp-plumber';
import gulpEslint from 'gulp-eslint';
import webpack from 'webpack';
import gulpWebpack from 'webpack-stream';
import changed from 'gulp-changed-in-place';

import { scripts as config, isProd } from './config';

export function esTranspile() {
  return (
    gulp
      .src(config.src)
      .pipe(plumber())
      // If you use it with gulp.watch, the second argument seems to be necessary.
      // https://www.npmjs.com/package/webpack-stream#usage-with-gulp-watch
      .pipe(gulpWebpack(require('../webpack.config.js'), webpack))
      .pipe(gulp.dest(config.dest))
  );
}

export function esLint() {
  return gulp
    .src(config.src)
    .pipe(changed({ firstPass: true }))
    .pipe(gulpEslint())
    .pipe(gulpEslint.format())
    .pipe(gulpIf(isProd, gulpEslint.failAfterError()));
}

export const scripts = gulp.series(esLint, esTranspile);
