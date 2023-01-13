const express = require('express');
const controller = require('../controllers/sports.controllers');

const router = express.Router();

router.get('/', controller.getSports);
router.get('/:id', controller.getSport);
router.post('/', controller.createSport);

module.exports = router;
