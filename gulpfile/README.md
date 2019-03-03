## Getting started

```
npm install
npm start
```

## Architecture

This architectural guideline serves to cut down the amount of time spent figuring out where new styles should go, where existing styles are and also limits the amount of duplication. An effort must be placed on keeping CSS modular and not repetitive.

I follow the following general file structure.

```
scss
├── global
│   ├── _base.scss
│   ├── _mixins.scss
│   ├── _variables.scss
│   ├── _alignment.scss
│   ├── _breakpoints.scss
│   ├── _buttons.scss
│   ├── _colors.scss
│   ├── _forms.scss
│   ├── _grid-layout.scss
│   ├── _icons.scss
│   ├── _mixins.scss
│   ├── _reset.scss
│   ├── _shared-styles.scss
│   ├── _spacing.scss
│   ├── _typography.scss
│   ├── _visibility.scss
│   ├── _z-index.scss
│   └── etc...
│
├── component
│   ├── _button.scss
│   ├── _page-title.scss
│   └── etc...
│
├── layout
│   ├── _header.scss
│   ├── _footer.scss
│   ├── _modal.scss
│   └── etc...
│
├── vendor
│   ├── _third-party.scss
│
├── _global.scss
│
│
├── style.scss
│
```

#### Global

All "base" and "global" styles should go here. Base styles are those involving resets, `html` and `body` styles, etc. Global styles are things that are either used over and over again (layout wrappers, for example).

#### layout (modules)

This is modules but I like to say it layout. Things should be broken down into reusable components whenever possible. Examples of modules include buttons, forms, sidebars, articles, comments, etc. Modules should be reusable in a number of different locations.

#### Components

Components compose larger pieces of a UI, comprised of multiple modules. For instance, a page title module might be used in a page header component, but the page header component would contain all specific styles related to the page header (specifically layout).

## gulpfile.js

```
const gulp = require('gulp');
const sass = require('gulp-sass');
const browserSync = require('browser-sync').create();
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssvariables = require('postcss-css-variables');
const calc = require('postcss-calc');

function style() {
  return gulp
    .src('./scss/**/*.scss')
    .pipe(sass({ outputStyle: 'expanded' }).on('error', sass.logError))
    .pipe(postcss([autoprefixer(), cssvariables({ preserve: true }), calc()]))
    .pipe(gulp.dest('./css'))
    .pipe(browserSync.stream());
}

function watch() {
  browserSync.init({
    server: {
      baseDir: './',
    },
  });
  gulp.watch('./scss/**/*.scss', style);
  gulp.watch('./*.html').on('change', browserSync.reload);
  gulp.watch('./js/**/*.js').on('change', browserSync.reload);
}

exports.style = style;
exports.watch = watch;

gulp.task('default', watch);
```
