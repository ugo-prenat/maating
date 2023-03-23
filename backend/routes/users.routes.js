const express = require('express');
const controller = require('../controllers/users.controllers');

const router = express.Router();

router.get('/', controller.getUsers);
router.post('/login', controller.loginUser);
router.get('/:id', controller.getUser);
router.get('/:id/comments', controller.getUserComments);
router.get('/:id/created-events', controller.getUserCreatedEvents);
router.get('/:id/joined-events', controller.getUserJoinedEvents);
router.post('/', controller.createUser);
router.patch('/:id', controller.updateUser);
router.delete('/:id', controller.deleteUser);

module.exports = router;
