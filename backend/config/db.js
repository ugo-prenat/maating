require('dotenv').config();

const DB_USERNAME = process.env.DB_USERNAME;
const DB_PASSWORD = process.env.DB_PASSWORD;
const DB_URL = `mongodb+srv://${DB_USERNAME}:${DB_PASSWORD}@maatingcluster.dxrsqz3.mongodb.net`;

const PORT = process.env.PORT;

module.exports = {
  mongo: { url: DB_URL },
  server: { port: PORT }
};
