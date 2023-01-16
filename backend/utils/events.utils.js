const isParticipantAlreadyInEvent = (event, participantId) => {
  return event.participants.some((p) => p._id.toString() === participantId);
};

module.exports = {
  isParticipantAlreadyInEvent
};
