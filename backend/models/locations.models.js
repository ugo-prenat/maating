const mongoose = require('mongoose');

const schema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    address: { type: String, required: true },
    thumbnail_url: { type: String, required: true },
    loc: {
      type: { type: String, default: 'Point' },
      coordinates: {
        type: [
          { type: Number, required: true }, // longitude
          { type: Number, required: true } // latitude
        ]
      }
    }
  },
  { versionKey: false }
);
schema.index({ loc: '2dsphere' });

module.exports = mongoose.model('Location', schema);
