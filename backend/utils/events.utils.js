const isParticipantAlreadyInEvent = (event, participantId) => {
  return event.participants.some((p) => p._id.toString() === participantId);
};

const formatEventsForMapDisplay = (events) => {
  grouped = events.reduce((r, v, i, a) => {
    if (
      v.location.loc.coordinates[0] === a.location.loc.coordinates[0][i - 1]
    ) {
      r[r.length - 1].push(v);
    } else {
      r.push(v === a[i + 1] ? [v] : v);
    }
    return r;
  }, []);

  console.log(events[0].location.loc.coordinates[0]);

  return { msg: 'testing...' };
};

module.exports = {
  isParticipantAlreadyInEvent,
  formatEventsForMapDisplay
};
