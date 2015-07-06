exports.config = {
  baseUrl: 'http://app',
  seleniumAddress: 'http://hub:4444/wd/hub',
  multiCapabilities: [
    {'browserName': 'chrome'},
    {'browserName': 'firefox'}
  ],
  specs: ['todo-spec.js']
};
