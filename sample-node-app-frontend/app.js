const backendHost = 'http://sample-app-backend-service/'

const express = require('express');

const app = express();

app.set('view engine', 'ejs');

app.get('/', async (req, res) => {
  const response = await fetch(backendHost);
  const responseBody = await response.text();
  res.send(`This is the frontend. Backend response: ${responseBody}`);
});

module.exports = app;
