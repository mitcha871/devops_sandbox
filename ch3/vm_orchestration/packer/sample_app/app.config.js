// Configuration file for PM2

module.exports = {
  apps : [{
    name   : "sample-app",
    script : "./app.js",  // Target to run.
    exec_mode: "cluster",  // Instead of a single process, run one process per CPU.
    instances: "max",
    env: {
      "NODE_ENV": "production"  // Tells Node.js to run in production mode.
    }
  }]
}
