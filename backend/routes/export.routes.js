const users = require('./users.routes');
const sports = require('./sports.routes');
const events = require('./events.routes');
const locations = require('./locations.routes');
const comments = require('./comments.routes');
const uploads = require('./uploads.routes');

module.exports = {
  users,
  sports,
  events,
  locations,
  comments,
  uploads
};
