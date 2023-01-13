const express = require('express');
const controller = require('../controllers/locations.controllers');

const router = express.Router();

router.get('/', controller.getLocations);
router.get('/:id', controller.getLocation);
router.post('/', controller.createLocation);
router.patch('/:id', controller.updateLocation);
router.delete('/:id', controller.deleteLocation);

module.exports = router;
