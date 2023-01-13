const express = require('express');
const controller = require('../controllers/comments.controllers');

const router = express.Router();

router.get('/', controller.getComments);
router.get('/:id', controller.getComment);
router.get('/user/:id', controller.getCommentsOnUser);
router.post('/', controller.createComment);
router.patch('/:id', controller.updateComment);
router.delete('/:id', controller.deleteComment);

module.exports = router;
