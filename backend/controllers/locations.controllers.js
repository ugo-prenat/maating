const Locations = require('../models/locations.models');

const getLocations = (req, res) => {
  return Locations.find()
    .then((locations) => res.status(200).json(locations))
    .catch((error) => res.status(500).json({ error }));
};
const getLocation = (req, res) => {
  return Locations.findById(req.params.id)
    .then((location) => res.status(200).json(location))
    .catch((error) => res.status(500).json({ error }));
};
const createLocation = (req, res) => {
  const location = new Locations(req.body);
  return location
    .save()
    .then((location) => res.status(201).json(location))
    .catch((error) => res.status(500).json(error));
};
const updateLocation = (req, res) => {
  return Locations.findByIdAndUpdate(req.params.id, req.body, { new: true })
    .then((location) => res.status(200).json(location))
    .catch((error) => res.status(500).json({ error }));
};
const deleteLocation = (req, res) => {
  return Locations.findByIdAndDelete(req.params.id)
    .then((location) => res.status(200).json(location))
    .catch((error) => res.status(500).json({ error }));
};

module.exports = {
  getLocations,
  getLocation,
  createLocation,
  updateLocation,
  deleteLocation
};
