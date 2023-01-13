const mongoose = require('mongoose');

const schema = new mongoose.Schema(
  {
    name: { type: String, required: true }
  },
  { versionKey: false }
);

module.exports = mongoose.model('Sport', schema);
