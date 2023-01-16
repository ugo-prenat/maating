const mongoose = require('mongoose');

const schema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    address: { type: String, required: true },
    thumbnail_url: { type: String, required: true },
    latitude: { type: Number, required: true },
    longitude: { type: Number, required: true }
  },
  { versionKey: false }
);

module.exports = mongoose.model('Location', schema);
