import gulp from 'gulp';
import gulpHtmlmin from 'gulp-htmlmin';

import { templates as config } from './config';

/**
 * HTML
 */
export function templates() {
  return gulp
    .src(config.src)
    .pipe(gulpHtmlmin({ collapseWhitespace: true }))
    .pipe(gulp.dest(config.dest));
}
