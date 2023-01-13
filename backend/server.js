require('dotenv').config();
const figlet = require('figlet');
const cors = require('cors');
const express = require('express');

const mongoose = require('mongoose');
const db = require('./config/db');
const routes = require('./routes/export.routes');
const logger = require('./logger.js');

const app = express();

mongoose
  .connect(db.mongo.url, { retryWrites: true, w: 'majority' })
  .then(() => {
    console.log('\nConnected to MongoDB');
    startServer();
  })
  .catch((err) => {
    console.error('Unable to conect to MongoDB: ');
    console.log(err);
  });

const startServer = () => {
  app.use(express.urlencoded({ extended: true }));
  app.use(express.json());
  app.use(cors());

  app.use((req, res, next) => {
    res.on('finish', () => {
      const status = res.statusCode;
      const log = `${req.method} ${req.originalUrl} - status ${status}`;

      status < 200
        ? logger.warn(log)
        : status < 400
        ? logger.info(log)
        : logger.error(log);
    });
    next();
  });

  app.use('/users', routes.users);
  app.use('/sports', routes.sports);
  app.use('/locations', routes.locations);
  app.use('/events', routes.events);
  app.use('/comments', routes.comments);
  app.use('/uploads', routes.uploads);

  app.listen(db.server.port, () => {
    console.log(`Server started on port ${db.server.port}`);
    console.log(figlet.textSync('Maating'));
  });
};
