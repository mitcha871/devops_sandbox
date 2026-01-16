const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World!\n');
});

const port = process.env.PORT || 8080;
server.listen(port, () => {
    console.log(`Listening on port ${port}`);
});

// Quit on CTRL+C
process.on('SIGINT', () => {
  console.log('Received SIGINT. Shutting down...');
  server.close(() => {
    process.exit(0);
  });
});

// Quit on Docker stop
process.on('SIGTERM', () => {
  console.log('Received SIGTERM. Shutting down...');
  server.close(() => {
    process.exit(0);
  });
});