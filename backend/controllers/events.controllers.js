const Events = require('../models/events.models');
const {
  isParticipantAlreadyInEvent,
  formatEventsForMapDisplay
} = require('../utils/events.utils');

const getMapEvents = (req, res) => {
  const { lat, lng, maxDistance, search } = req.query;

  if (lat && lng && maxDistance) {
    return (
      Events.find()
        // select events by the given coordinates
        .populate('location', null, {
          loc: {
            $near: {
              $geometry: {
                type: 'Point',
                coordinates: [parseFloat(lng), parseFloat(lat)]
              },
              $maxDistance: parseInt(maxDistance)
            }
          }
        })
        .populate('sport')
        .then((events) =>
          res.status(200).json(
            // format events for map display before sending them to the frontend
            formatEventsForMapDisplay(
              events.filter(
                (e) =>
                  e.location &&
                  e.sport.name.toLowerCase().includes(search.toLowerCase())
              )
            )
          )
        )
        .catch((error) => res.status(500).json({ error }))
    );
  }
  return res
    .status(400)
    .json({ error: 'Missing lat, lng or maxDistance params' });
};

const getEvents = (req, res) => {
  const { lat, lng, maxDistance } = req.query;

  if (lat && lng) {
    return (
      Events.find()
        // select events by the given coordinates
        .populate('location', null, {
          loc: {
            $near: {
              $geometry: {
                type: 'Point',
                coordinates: [parseFloat(lng), parseFloat(lat)]
              },
              $maxDistance: parseInt(maxDistance ? maxDistance : '0')
            }
          }
        })
        .populate('sport')
        .populate('organizer')
        .populate('participants')
        .then((events) =>
          res.status(200).json(events.filter((e) => e.location))
        )
        .catch((error) => res.status(500).json({ error }))
    );
  }

  return Events.find()
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((events) => res.status(200).json(events))
    .catch((error) => res.status(500).json({ error }));
};
const getEvent = (req, res) => {
  return Events.findById(req.params.id)
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((event) => res.status(200).json(event))
    .catch((error) => res.status(500).json({ error }));
};
const getEventByOrganizerId = (req, res) => {
  return Events.find({ organizer: req.params.id })
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((events) => res.status(200).json(events))
    .catch((error) => res.status(500).json({ error }));
};
const getEventWithParticipantId = (req, res) => {
  return Events.find({ participants: req.params.id })
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((events) => res.status(200).json(events))
    .catch((error) => res.status(500).json({ error }));
};
const getEventParticipants = (req, res) => {
  return Events.findById(req.params.id)
    .populate('participants')
    .then((event) => res.status(200).json(event.participants))
    .catch((error) => res.status(500).json({ error }));
};
const createEvent = (req, res) => {
  const event = new Events(req.body);
  return event
    .save()
    .then((event) => res.status(201).json(event))
    .catch((error) => res.status(500).json(error));
};
const addEventParticipant = async (req, res) => {
  const participantId = req.body.participantId;
  const event = await Events.findById(req.params.id);

  if (!participantId)
    return res.status(400).json({ error: 'Missing participantId' });

  if (isParticipantAlreadyInEvent(event, participantId))
    return res.status(400).json({ error: 'Participant already in event' });

  return Events.findByIdAndUpdate(
    req.params.id,
    {
      $push: {
        participants: participantId,
        additional_places: req.body.additionalPlaces // add additional places linked to the participant
      }
    },
    { new: true }
  )
    .then((event) => res.status(200).json(event))
    .catch((error) => res.status(500).json({ error }));
};
const updateEvent = (req, res) => {
  return Events.findByIdAndUpdate(req.params.id, req.body, { new: true })
    .then((event) => res.status(200).json(event))
    .catch((error) => res.status(500).json({ error }));
};
const deleteEvent = (req, res) => {
  return Events.findByIdAndDelete(req.params.id)
    .then((event) => res.status(200).json(event))
    .catch((error) => res.status(500).json({ error }));
};

module.exports = {
  getEvents,
  getMapEvents,
  getEvent,
  getEventByOrganizerId,
  getEventWithParticipantId,
  getEventParticipants,
  createEvent,
  addEventParticipant,
  updateEvent,
  deleteEvent
};
