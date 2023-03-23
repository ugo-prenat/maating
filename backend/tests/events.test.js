const {
  formatEventsForMapDisplay,
  groupEventsByLoc,
  isParticipantAlreadyInEvent
} = require('../utils/events.utils');
const {
  events,
  groupedByLocEvents,
  mapDisplayFormattedEvents
} = require('./mocks/events.mocks');

describe('Sports', () => {
  it('Checks if participant is already in event', () => {
    const alreadyInEventParticipantId = '5f9f1b9b9c9d440000a1b0f1';
    const notInEventParticipantId = '5f9f1b9b9c9d440000a1b0f2';
    const event = events[0];

    const participantAlreadyInEvent = isParticipantAlreadyInEvent(
      event,
      alreadyInEventParticipantId
    );
    const participantNotInEvent = isParticipantAlreadyInEvent(
      event,
      notInEventParticipantId
    );

    expect(participantAlreadyInEvent).toBe(true);
    expect(participantNotInEvent).toBe(false);
  });
  it('Groups events by location', () => {
    const ungroupedEvents = events;
    const groupedEvents = groupedByLocEvents;

    expect(
      groupEventsByLoc(ungroupedEvents, 'location.loc.coordinates')
    ).toEqual(groupedEvents);
  });
  it('Formats events for map display', () => {
    const unformattedEvents = events;
    const formattedEvents = mapDisplayFormattedEvents;

    expect(formatEventsForMapDisplay(unformattedEvents)).toEqual(
      formattedEvents
    );
  });
});
