const events = [
  {
    _id: '5f0b9f9e0f1cfc0017b660e5',
    name: 'Event 1',
    duration: 60,
    price: 10,
    description: 'Event 1 description',
    sport: '5f0b9f9e0f1cfc0017b660e4',
    level: 1,
    max_nb: 10,
    organizer: '5f0b9f9e0f1cfc0017b660e3',
    participants: [
      {
        _id: '5f9f1b9b9c9d440000a1b0f1',
        name: 'Participant 1'
      }
    ],
    is_private: false,
    private_code: null,
    location: {
      _id: '5f0b9f9e0f1cfc0017b660e2',
      name: 'Location 1',
      adress: 'Location 1 adress',
      thumbnail_url: 'Location 1 thumbnail_url',
      loc: {
        coordinates: [1, 1]
      }
    }
  },
  {
    _id: '5f0b9f9e0f1cfc0017b660e5',
    name: 'Event 2',
    duration: 60,
    price: 10,
    description: 'Event 2 description',
    sport: '5f0b9f9e0f1cfc0017b660e4',
    level: 1,
    max_nb: 10,
    organizer: '5f0b9f9e0f1cfc0017b660e3',
    participants: [],
    is_private: false,
    private_code: null,
    location: {
      _id: '5f0b9f9e0f1cfc0017b660e2',
      name: 'Location 1',
      adress: 'Location 1 adress',
      thumbnail_url: 'Location 1 thumbnail_url',
      loc: {
        coordinates: [1, 1]
      }
    }
  },
  {
    _id: '5f0b9f9e0f1cfc0017b660e5',
    name: 'Event 3',
    duration: 60,
    price: 10,
    description: 'Event 3 description',
    sport: '5f0b9f9e0f1cfc0017b660e4',
    level: 1,
    max_nb: 10,
    organizer: '5f0b9f9e0f1cfc0017b660e3',
    participants: [],
    is_private: false,
    private_code: null,
    location: {
      _id: '5f0b9f9e0f1cfc0017b660e2',
      name: 'Location 1',
      adress: 'Location 1 adress',
      thumbnail_url: 'Location 1 thumbnail_url',
      loc: {
        coordinates: [2, 2]
      }
    }
  }
];
const groupedByLocEvents = {
  '1,1': [events[0], events[1]],
  '2,2': [events[2]]
};
const mapDisplayFormattedEvents = [
  {
    coordinates: [1, 1],
    eventsNb: 2,
    id: '1-1'
  },
  {
    coordinates: [2, 2],
    eventsNb: 1,
    id: '2-2'
  }
];

module.exports = {
  events,
  groupedByLocEvents,
  mapDisplayFormattedEvents
};
