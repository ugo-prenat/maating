const Sports = require('../models/sports.models');

const getSports = (req, res) => {
  return Sports.find()
    .then((sports) => res.status(200).json(sports))
    .catch((error) => res.status(500).json({ error }));
};
const getSport = (req, res) => {
  return Sports.findById(req.params.id)
    .then((sport) => res.status(200).json(sport))
    .catch((error) => res.status(500).json({ error }));
};
const createSport = (req, res) => {
  const sport = new Sports(req.body);
  return sport
    .save()
    .then((sport) => res.status(201).json(sport))
    .catch((error) => res.status(500).json(error));
};

module.exports = {
  getSports,
  getSport,
  createSport
};
