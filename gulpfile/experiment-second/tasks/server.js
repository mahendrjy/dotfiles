import browserSync from 'browser-sync';

const server = browserSync.create();

/**
 * Restart the development server
 */
export function reload(cb) {
  server.reload();
  cb();
}

/**
 * Launch development server
 */
export function serve(cb) {
  server.init({
    server: {
      baseDir: './public',
    },
  });
  cb();
}
