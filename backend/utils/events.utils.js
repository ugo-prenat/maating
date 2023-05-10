const isParticipantAlreadyInEvent = (event, participantId) => {
  return event.participants.some((p) => p._id.toString() === participantId);
};

const formatEventsForMapDisplay = (events) => {
  const grouped = Object.values(
    groupEventsByLoc(events, 'location.loc.coordinates') // group events with the same coordinates
  );
  // return an array of events with coordinates, eventsNb and id
  return grouped.map((group) => ({
    coordinates: group[0].location.loc.coordinates,
    eventsNb: group.length,
    id: group[0].location.loc.coordinates.join('-') // generate an id for Google Maps marker creation
  }));
};

const groupEventsByLoc = (array, property) => {
  // group events with the same coordinates
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

const generatePrivateCode = () => Math.floor(1000 + Math.random() * 9000);

module.exports = {
  isParticipantAlreadyInEvent,
  formatEventsForMapDisplay,
  groupEventsByLoc,
  generatePrivateCode
};
