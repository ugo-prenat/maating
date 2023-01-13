const Users = require('../models/users.models');
const bcrypt = require('bcrypt');

const saltRounds = 10;

const isObjectEmpty = (obj) => {
  return !obj || Object.keys(obj).length === 0;
};
const userAlreadyExists = (user) => {
  return Users.findOne({ email: user.email })
    .then((user) => {
      if (user) return true;
      false;
    })
    .catch(() => false);
};
const hashPassword = (password) => bcrypt.hashSync(password, saltRounds);
const isCorrectPassword = (password, hash) =>
  bcrypt.compareSync(password, hash);

module.exports = {
  isObjectEmpty,
  userAlreadyExists,
  hashPassword,
  isCorrectPassword
};
