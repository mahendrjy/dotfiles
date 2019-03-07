import del from 'del';

/**
 * Empty the output destination directory
 */
export function clean() {
  return del(['public']);
}
