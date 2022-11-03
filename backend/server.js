const express = require('express')
const figlet = require('figlet')
const app = express()


const PORT = 4000
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  figlet('Maating', (_, data) => console.log(data))
})