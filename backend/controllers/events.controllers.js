const Events = require('../models/events.models');
const {
  tempFunc,
  isParticipantAlreadyInEvent
} = require('../utils/events.utils');

const getEvents = (req, res) => {
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
    { $push: { participants: participantId } },
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
  getEvent,
  getEventParticipants,
  createEvent,
  addEventParticipant,
  updateEvent,
  deleteEvent
};
