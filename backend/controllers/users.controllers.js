const Users = require('../models/users.models');
const Events = require('../models/events.models');
const Comments = require('../models/comments.models');
const {
  userAlreadyExists,
  isObjectEmpty,
  isCorrectPassword,
  hashPassword
} = require('../utils/users.utils');

const getUsers = (req, res) => {
  return Users.find()
    .populate([{ path: 'sports', populate: { path: 'sport' } }])
    .then((users) => res.status(200).json(users))
    .catch((error) => res.status(500).json({ error }));
};
const getUser = (req, res) => {
  return Users.findById(req.params.id)
    .populate([{ path: 'sports', populate: { path: 'sport' } }])
    .then((user) => res.status(200).json(user))
    .catch((error) => res.status(500).json({ error }));
};
const getUserCreatedEvents = (req, res) => {
  return Events.find({ organizer: req.params.id })
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((events) => res.status(200).json(events))
    .catch((error) => res.status(500).json({ error }));
};
const getUserJoinedEvents = (req, res) => {
  return Events.find({ participants: req.params.id })
    .populate('sport')
    .populate('organizer')
    .populate('participants')
    .populate('location')
    .then((events) => res.status(200).json(events))
    .catch((error) => res.status(500).json({ error }));
};
const loginUser = (req, res) => {
    console.log(req.body)
  return Users.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) return res.status(404).json({ error: 'User not found' });

      if (!isCorrectPassword(req.body.password, user.password))
        return res.status(401).json({ error: 'Incorrect password' });

      return res.status(200).json(user);
    })
    .catch((error) => res.status(500).json({ error }));
};
const createUser = async (req, res) => {
  if (isObjectEmpty(req.body))
    return res.status(400).json({ error: 'Missing request body' });

  if (await userAlreadyExists(req.body))
    return res.status(400).json({ error: 'User already exists' });

  const user = new Users(req.body);
  return user
    .save()
    .then((user) => res.status(201).json(user))
    .catch((error) => res.status(500).json(error));
};
const updateUser = (req, res) => {
  const data = req.body;

  if (data.password) data.password = hashPassword(data.password);

  return Users.findByIdAndUpdate(req.params.id, data, { new: true })
    .then((user) => res.status(200).json(user))
    .catch((error) => res.status(500).json({ error }));
};
const deleteUser = (req, res) => {
  return Users.findByIdAndDelete(req.params.id)
    .then((user) => res.status(200).json(user))
    .catch((error) => res.status(500).json({ error }));
};
const getUserComments = (req, res) => {
  return Comments.find({ author: req.params.id })
    .populate('author')
    .populate('user')
    .populate('event')
    .then((comments) => res.status(200).json(comments))
    .catch((error) => res.status(500).json({ error }));
};

module.exports = {
  getUsers,
  getUser,
  getUserCreatedEvents,
  getUserJoinedEvents,
  loginUser,
  createUser,
  updateUser,
  deleteUser,
  getUserComments
};
