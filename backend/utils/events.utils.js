const isParticipantAlreadyInEvent = (event, participantId) => {
  return event.participants.some((p) => p._id.toString() === participantId);
};

const formatEventsForMapDisplay = (events) => {
  const grouped = Object.values(
    groupEventsByLoc(events, 'location.loc.coordinates')
  );
  return grouped.map((group) => ({
    coordinates: group[0].location.loc.coordinates,
    eventsNb: group.length,
    id: group[0].location.loc.coordinates.join('-') // generate an id for Google Maps marker creation
  }));
};

const groupEventsByLoc = (array, property) => {
  var hash = {},
    props = property.split('.');
  for (var i = 0; i < array.length; i++) {
    var key = props.reduce(function (acc, prop) {
      return acc && acc[prop];
    }, array[i]);
    if (!hash[key]) hash[key] = [];
    hash[key].push(array[i]);
  }
  return hash;
};

module.exports = {
  isParticipantAlreadyInEvent,
  formatEventsForMapDisplay,
  groupEventsByLoc
};
