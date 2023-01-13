const express = require('express');
const controller = require('../controllers/uploads.controllers');
const upload = require('../config/multer');

const router = express.Router();

router.get('/:id/:filename', controller.getImage);
router.post('/', upload.single('file'), controller.uploadImage);

module.exports = router;
