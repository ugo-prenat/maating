const colors = require('colors');

colors.enable();

module.exports = {
  warn: (msg) => console.log(msg.yellow),
  error: (msg) => console.log(msg.red),
  info: (msg) => console.log(msg.blue)
};
