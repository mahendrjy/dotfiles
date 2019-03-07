const ASSET_ROOT = 'src';
const DEST_ROOT = 'public';

export const sass = {
  src: `${ASSET_ROOT}/sass/**/*.scss`,
  dest: `${DEST_ROOT}/styles`,
};

export const scripts = {
  srcRoot: `${ASSET_ROOT}/js`,
  src: `${ASSET_ROOT}/js/**/*.js`,
  dest: `${DEST_ROOT}/js`,
  babelrc: {
    presets: [['@babel/env', { targets: '> 0.25%, not dead' }]],
  },
};

export const templates = {
  root: `${ASSET_ROOT}/templates`,
  edges: `${ASSET_ROOT}/templates/**/*.edge`,
  pages: `${ASSET_ROOT}/templates/pages/**/*.edge`,
  data: `${ASSET_ROOT}/templates/data.json`,
  helper: `${ASSET_ROOT}/templates/helper.js`,
  dest: DEST_ROOT,
};

export const images = {
  src: `${ASSET_ROOT}/images/**/*.*`,
  dest: `${DEST_ROOT}/images`,
};

export const isProd = process.env.NODE_ENV === 'production';
