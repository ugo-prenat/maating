const Comments = require('../models/comments.models');
const { updateUserPersonalRating } = require('../utils/comments.utils');

const getComments = (req, res) => {
  return Comments.find()
    .populate('author')
    .populate('event')
    .then((comments) => res.status(200).json(comments))
    .catch((error) => res.status(500).json({ error }));
};
const getComment = (req, res) => {
  return Comments.findById(req.params.id)
    .populate('author')
    .populate('user')
    .populate('event')
    .then((comment) => res.status(200).json(comment))
    .catch((error) => res.status(500).json({ error }));
};
const createComment = (req, res) => {
  const comment = new Comments(req.body);
  return comment
    .save()
    .then((comment) => {
      updateUserPersonalRating(comment)
        .then(() => res.status(201).json(comment))
        .catch((error) => res.status(500).json({ error }));
    })
    .catch((error) => res.status(500).json(error));
};
const updateComment = (req, res) => {
  return Comments.findByIdAndUpdate(req.params.id, req.body, { new: true })
    .then((comment) => res.status(200).json(comment))
    .catch((error) => res.status(500).json({ error }));
};
const deleteComment = (req, res) => {
  return Comments.findByIdAndDelete(req.params.id)
    .then((comment) => res.status(200).json(comment))
    .catch((error) => res.status(500).json({ error }));
};
const getCommentsOnUser = (req, res) => {
  return Comments.find({ user: req.params.id })
    .populate('author')
    .populate('user')
    .populate('event')
    .then((comments) => res.status(200).json(comments))
    .catch((error) => res.status(500).json({ error }));
};

module.exports = {
  getComments,
  getComment,
  createComment,
  updateComment,
  deleteComment,
  getCommentsOnUser
};
