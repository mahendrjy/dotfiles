import gulp from 'gulp';

import { templates as config } from './config';

/**
 * HTML
 */
export function templates() {
  return gulp.src(config.pages).pipe(gulp.dest(config.dest));
}
