const express = require('express');
const controller = require('../controllers/events.controllers');

const router = express.Router();

router.get('/', controller.getEvents);
router.get('/map', controller.getMapEvents);
router.get('/shared', controller.getSharedEvents);
router.get('/:id', controller.getEvent);
router.get('/organizer/:id', controller.getEventByOrganizerId);
router.get('/participant/:id', controller.getEventWithParticipantId);
router.get('/:id/participants', controller.getEventParticipants);
router.post('/', controller.createEvent);
router.post('/:id/participants', controller.addEventParticipant);
router.patch('/:id', controller.updateEvent);
router.delete('/:id', controller.deleteEvent);

module.exports = router;
