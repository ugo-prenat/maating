const mongoose = require('mongoose');

const AdditionalPlacesSchema = new mongoose.Schema(
  {
    participantId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    nbPlaces: { type: Number, required: true }
  },
  { _id: false }
);

const schema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    date: { type: String, required: true },
    duration: { type: Number, required: true },
    price: { type: Number, required: true },
    description: { type: String, required: true },
    sport: { type: mongoose.Schema.Types.ObjectId, ref: 'Sport' },
    level: { type: Number, required: true },
    max_nb: { type: Number, required: true },
    organizer: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    participants: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    additional_places: [AdditionalPlacesSchema],
    is_private: { type: Boolean, required: true },
    private_code: { type: Number },
    location: { type: mongoose.Schema.Types.ObjectId, ref: 'Location' }
  },
  { versionKey: false }
);

module.exports = mongoose.model('Event', schema);
