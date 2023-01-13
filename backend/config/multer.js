const db = require('./db');
const multer = require('multer');
const { GridFsStorage } = require('multer-gridfs-storage');

const storage = new GridFsStorage({
  url: db.mongo.url,
  options: { useNewUrlParser: true, useUnifiedTopology: true },
  file: () => {
    return {
      filename: Date.now() + '-test',
      bucketName: 'uploads'
    };
  }
});

const fileFilter = (req, file, callback) => {
  if (
    file.mimetype === 'image/png' ||
    file.mimetype === 'image/jpg' ||
    file.mimetype === 'image/jpeg'
  )
    callback(null, true);
  else callback(null, false);
};

module.exports = multer({
  storage,
  fileFilter,
  limits: { fileSize: 1000000 }
});
