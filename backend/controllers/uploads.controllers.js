const mongoose = require('mongoose');
const { GridFSBucket } = require('mongodb');
const db = require('../config/db');
const { encodeOriginalname } = require('../utils/uploads.utils');

const connect = mongoose.createConnection(db.mongo.url);
let gfs;
connect.once('open', () => {
  gfs = new GridFSBucket(connect.db, { bucketName: 'uploads' });
});

const getImage = (req, res) => {
  const id = req.params.id;

  gfs.find({ filename: id }).toArray((error, files) => {
    if (error) return res.status(400).json({ error });
    if (!files[0] || files.length === 0)
      return res.status(404).json({ error: 'this file does not exist' });

    gfs.openDownloadStreamByName(id).pipe(res); // pipe the file to the response
  });
};
const uploadImage = (req, res) => {
  const originalname = encodeOriginalname(req.file.originalname);
  const url = `/uploads/${req.file.filename}/${originalname}`;
  res.status(201).json({ url });
};

module.exports = {
  getImage,
  uploadImage
};
