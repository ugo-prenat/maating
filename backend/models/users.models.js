const mongoose = require('mongoose');

const sportSchema = mongoose.Schema(
  {
    sport: { type: mongoose.Schema.Types.ObjectId, ref: 'Sport' },
    level: Number
  },
  {
    _id: false,
    versionKey: false
  }
);

const schema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    sports: [sportSchema],
    email: { type: String, required: true },
    password: { type: String, required: true },
    age: { type: Number, required: true },
    location: { type: String, required: true },
    mobility_range: { type: Number, required: true },
    avatar_url: { type: String, required: true },
    personal_rating: { type: Number },
    rating_nb: { type: Number, required: true }
  },
  { versionKey: false }
);

module.exports = mongoose.model('User', schema);
