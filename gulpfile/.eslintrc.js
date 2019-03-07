module.exports = {
  env: {
    es6: true,
    browser: true,
  },
  extends: 'airbnb-base',
  rules: {
    // Never use these last 3 in a real application... I mean never!
    'no-alert': 0,
    'no-console': 0,
    'no-debugger': 0,
  },
};
