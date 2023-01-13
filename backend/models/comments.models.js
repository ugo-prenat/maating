const mongoose = require('mongoose');

const schema = new mongoose.Schema(
  {
    author: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    date: { type: String, required: true },
    event: { type: mongoose.Schema.Types.ObjectId, ref: 'Event' },
    note: { type: Number, required: true },
    body: { type: String }
  },
  { versionKey: false }
);

module.exports = mongoose.model('Comment', schema);
