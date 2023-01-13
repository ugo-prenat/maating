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
    firstname: { type: String, required: true },
    lastname: { type: String, required: true },
    sports: [sportSchema],
    email: { type: String, required: true },
    password: { type: String, required: true },
    age: { type: Number, required: true },
    mobility_range: { type: Number, required: true },
    avatar_url: { type: String, required: true },
    personal_rating: { type: Number, required: true },
    rating_nb: { type: Number, required: true }
  },
  { versionKey: false }
);

module.exports = mongoose.model('User', schema);
