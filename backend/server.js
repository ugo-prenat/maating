require('dotenv').config();
const figlet = require('figlet');
const cors = require('cors');
const express = require('express');
const morgan = require('morgan');

const mongoose = require('mongoose');
const db = require('./config/db');
const routes = require('./routes/export.routes');

const app = express();
app.use(morgan('dev'));

mongoose.set('strictQuery', false);
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
