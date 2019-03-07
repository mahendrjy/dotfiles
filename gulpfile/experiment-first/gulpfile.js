// Node Packages
const gulp = require('gulp');
const pump = require('pump');
const del = require('del');
<<<<<<< HEAD:gulpfile/experiment-first/gulpfile.js
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
=======
const webpack = require('webpack');
const webpackStream = require('webpack-stream');
const browserSync = require('browser-sync').create();
const vinylNamed = require('vinyl-named');
const through2 = require('through2');
const gulpZip = require('gulp-zip');
const gulpUglify = require('gulp-uglify');
const gulpSourcemaps = require('gulp-sourcemaps');
const gulpPostcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const postcssUncss = require('postcss-uncss');
const gulpSass = require('gulp-sass');
const gulpBabel = require('gulp-babel');
const gulpImagemin = require('gulp-imagemin');
const gulpHtmlmin = require('gulp-htmlmin');
const imageminPngquant = require('imagemin-pngquant');
const imageminJpegRecompress = require('imagemin-jpeg-recompress');

// Entry point retreive from webpack
const entry = require('./webpack/entry');

// Transform Entry point into an Array for defining in gulp file
const entryArray = Object.values(entry);

// Supported Browsers
const supportedBrowsers = [
  'last 3 versions', // http://browserl.ist/?q=last+3+versions
  '>1%', // https://browserl.ist/?q=%3E1%25
  // 'ie >= 10', // http://browserl.ist/?q=ie+%3E%3D+10
  // 'edge >= 12', // http://browserl.ist/?q=edge+%3E%3D+12
  // 'firefox >= 28', // http://browserl.ist/?q=firefox+%3E%3D+28
  // 'chrome >= 21', // http://browserl.ist/?q=chrome+%3E%3D+21
  // 'safari >= 6.1', // http://browserl.ist/?q=safari+%3E%3D+6.1
  // 'opera >= 12.1', // http://browserl.ist/?q=opera+%3E%3D+12.1
  // 'ios >= 7', // http://browserl.ist/?q=ios+%3E%3D+7
  // 'android >= 4.4', // http://browserl.ist/?q=android+%3E%3D+4.4
  // 'blackberry >= 10', // http://browserl.ist/?q=blackberry+%3E%3D+10
  // 'operamobile >= 12.1', // http://browserl.ist/?q=operamobile+%3E%3D+12.1
  // 'samsung >= 4', // http://browserl.ist/?q=samsung+%3E%3D+4
];

// Config
const autoprefixConfig = { browsers: supportedBrowsers, cascade: false };
const babelConfig = { targets: { browsers: supportedBrowsers } };

// Paths for reuse
const exportPath = './client/dist/**/*';
const srcPath = (file, watch = false) => {
  if (file === 'scss' && watch === false) return './client/src/scss/styles.scss';
  if (file === 'scss' && watch === true) return './client/src/scss/**/*.scss';
  if (file === 'js' && watch === false) return entryArray;
  if (file === 'js' && watch === true) return './client/src/js/**/*.js';
  if (file === 'html') return './client/src/**/*.html';
  if (file === 'img') return './client/src/img/**/*.{png,jpeg,jpg,svg,gif}';
  console.error('Unsupported file type entered into Gulp Task Runner for Source Path');
};
const distPath = (file, serve = false) => {
  if (['css', 'js', 'img'].includes(file)) return `./client/dist/${file}`;
  if (file === 'html' && serve === false) return './client/dist/**/*.html';
  if (file === 'html' && serve === true) return './client/dist';
  console.error('Unsupported file type entered into Gulp Task Runner for Dist Path');
};

/**
 * Cleaning Tasks
 */

// Clean Markup Task
const cleanMarkup = mode => () => (['development', 'production'].includes(mode) ? del([distPath('html')]) : undefined);

// Clean Images Task
const cleanImages = mode => () => (['development', 'production'].includes(mode) ? del([distPath('img')]) : undefined);

// Clean Styles Task
const cleanStyles = mode => () => (['development', 'production'].includes(mode) ? del([distPath('css')]) : undefined);

// Clean Scripts Task
const cleanScripts = mode => () => (['development', 'production'].includes(mode) ? del([distPath('js')]) : undefined);

// Clean the zip file
const cleanExport = mode => () => (['development', 'production'].includes(mode) ? del(['./client.zip']) : undefined);

/**
 * Building Tasks
 */

// Build Markup Tasks
const buildMarkup = mode => (done) => {
  ['development', 'production'].includes(mode)
    ? pump(
      [
        gulp.src(srcPath('html')),
        ...(mode === 'production' ? [gulpHtmlmin({ collapseWhitespace: true })] : []),
        gulp.dest(distPath('html', true)),
      ],
      done,
>>>>>>> a0415f80a146aefe4054c806a6844bae9427547f:gulpfile/gulpfile.js
    )
    : undefined;
};

// Build Images Task
const buildImages = mode => (done) => {
  ['development', 'production'].includes(mode)
    ? pump(
      [
        gulp.src(srcPath('img')),
        gulpImagemin([
          gulpImagemin.gifsicle(),
          gulpImagemin.jpegtran(),
          gulpImagemin.optipng(),
          gulpImagemin.svgo(),
          imageminPngquant(),
          imageminJpegRecompress(),
        ]),
        gulp.dest(distPath('img')),
        browserSync.stream(),
      ],
      done,
    )
<<<<<<< HEAD:gulpfile/experiment-first/gulpfile.js
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
=======
    : undefined;
};

// Build Styles Task
const buildStyles = mode => (done) => {
  let outputStyle;
  if (mode === 'development') outputStyle = 'nested';
  else if (mode === 'production') outputStyle = 'compressed';
  else outputStyle = undefined;

  const postcssPlugins = [
    autoprefixer(autoprefixConfig),
    postcssUncss({ html: [distPath('html')] }),
  ];

  ['development', 'production'].includes(mode)
    ? pump(
      [
        gulp.src(srcPath('scss')),
        gulpSourcemaps.init({ loadMaps: true }),
        gulpSass({ outputStyle }),
        gulpPostcss(postcssPlugins),
        gulpSourcemaps.write('./'),
        gulp.dest(distPath('css')),
        browserSync.stream(),
      ],
      done,
    )
    : undefined;
};

// Build Scripts Task
const buildScripts = mode => (done) => {
  let streamMode;
  if (mode === 'development') streamMode = require('./webpack/webpack.dev');
  else if (mode === 'production') streamMode = require('./webpack/webpack.prod');
  else streamMode = undefined;

  ['development', 'production'].includes(mode)
    ? pump(
      [
        gulp.src(srcPath('js')),
        vinylNamed(),
        webpackStream(streamMode, webpack),
        gulpSourcemaps.init({ loadMaps: true }),
        through2.obj(function (file, enc, cb) {
          const isSourceMap = /\.map$/.test(file.path);
          if (!isSourceMap) this.push(file);
          cb();
        }),
        gulpBabel({ presets: [['env', babelConfig]] }),
        ...(mode === 'production' ? [gulpUglify()] : []),
        gulpSourcemaps.write('./'),
        gulp.dest(distPath('js')),
        browserSync.stream(),
      ],
      done,
    )
    : undefined;
};

/**
 * Generic Task for all Main Gulp Build/Export Tasks
 */

// Generic Task
const genericTask = (mode, context = 'building') => {
  let port;
  let modeName;

  if (mode === 'development') {
    port = '3000';
    modeName = 'Development Mode';
  } else if (mode === 'production') {
    port = '8000';
    modeName = 'Production Mode';
  } else {
    port = undefined;
    modeName = undefined;
  }

  // Combine all booting tasks into one array!
  const allBootingTasks = [
    Object.assign(cleanMarkup(mode), {
      displayName: `Booting Markup Task: Clean - ${modeName}`,
    }),
    Object.assign(buildMarkup(mode), {
      displayName: `Booting Markup Task: Build - ${modeName}`,
    }),
    Object.assign(cleanImages(mode), {
      displayName: `Booting Images Task: Clean - ${modeName}`,
    }),
    // Object.assign(buildImages(mode), {
    //   displayName: `Booting Images Task: Build - ${modeName}`,
    // }),
    Object.assign(cleanStyles(mode), {
      displayName: `Booting Styles Task: Clean - ${modeName}`,
    }),
    // Object.assign(buildStyles(mode), {
    //   displayName: `Booting Styles Task: Build - ${modeName}`,
    // }),
    Object.assign(cleanScripts(mode), {
      displayName: `Booting Scripts Task: Clean - ${modeName}`,
    }),
    Object.assign(buildScripts(mode), {
      displayName: `Booting Scripts Task: Build - ${modeName}`,
    }),
  ];

  // Browser Loading & Watching
  const browserLoadingWatching = (done) => {
    browserSync.init({ port, server: distPath('html', true) });

    // Watch - Markup
    gulp.watch(srcPath('html'), true).on(
      'all',
      gulp.series(
        Object.assign(cleanMarkup(mode), {
          displayName: `Watching Markup Task: Clean - ${modeName}`,
        }),
        Object.assign(buildMarkup(mode), {
          displayName: `Watching Markup Task: Build - ${modeName}`,
        }),
      ),
      browserSync.reload,
    );
    done();

    // Watch - Images
    gulp.watch(srcPath('img', true)).on(
      'all',
      gulp.series(
        Object.assign(cleanImages(mode), {
          displayName: `Watching Images Task: Clean - ${modeName}`,
        }),
        Object.assign(buildImages(mode), {
          displayName: `Watching Images Task: Build - ${modeName}`,
        }),
      ),
      browserSync.reload,
    );

    // Watch - Styles
    gulp.watch(srcPath('scss', true)).on(
      'all',
      gulp.series(
        Object.assign(cleanStyles(mode), {
          displayName: `Watching Styles Task: Clean - ${modeName}`,
        }),
        // Object.assign(buildStyles(mode), {
        //   displayName: `Watching Styles Task: Build - ${modeName}`,
        // }),
      ),
      browserSync.reload,
    );

    // Watch - Scripts
    gulp.watch(srcPath('js', true)).on(
      'all',
      gulp.series(
        Object.assign(cleanScripts(mode), {
          displayName: `Watching Scripts Task: Clean - ${modeName}`,
        }),
        Object.assign(buildScripts(mode), {
          displayName: `Watching Scripts Task: Build - ${modeName}`,
        }),
      ),
      browserSync.reload,
    );
  };

  // Exporting Zip
  const exportingZip = (done) => {
    pump([gulp.src(exportPath), gulpZip('./client.zip'), gulp.dest('./')], done);
  };

  // Returning Tasks based on Building Context
  if (context === 'building') {
    return [
      ...allBootingTasks,
      Object.assign(browserLoadingWatching, {
        displayName: `Browser Loading & Watching Task - ${modeName}`,
      }),
    ];
  }

  // Returning Tasks based on Exporting Context
  if (context === 'exporting') {
    return [
      cleanExport(mode),
      ...allBootingTasks,
      Object.assign(exportingZip, {
        displayName: `Exporting Zip Task - ${modeName}`,
      }),
    ];
  }

  // No Side-Effects Please
  return undefined;
};

/**
 * Main Gulp Build/Export Tasks that are inserted within `package.json`
 */

// Default (`npm start` or `yarn start`) => Production
gulp.task('default', gulp.series(...genericTask('production', 'building')));

// Dev (`npm run dev` or `yarn run dev`) => Development
gulp.task('dev', gulp.series(...genericTask('development', 'building')));

// Export (`npm run export` or `yarn run export`)
gulp.task('export', gulp.series(...genericTask('production', 'exporting')));
>>>>>>> a0415f80a146aefe4054c806a6844bae9427547f:gulpfile/gulpfile.js
