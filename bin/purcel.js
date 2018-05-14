#!/usr/bin/env node

const childProcess = require('child_process');
const path = require('path');

let purcelPath;

switch (process.platform) {
  case 'linux':
    purcelPath = path.join(__dirname, 'linux', 'purcel');
    break;
  case 'darwin':
    purcelPath = path.join(__dirname, 'osx', 'purcel');
    break;
  default:
    purcelPath = path.join(__dirname, process.platform, 'purcel');
    break;
};

const purcel = childProcess.spawn(purcelPath, process.argv.slice(2));

purcel.stdout.on('data', function(data) { process.stdout.write(data); });
purcel.stderr.on('data', function(data) { process.stderr.write(data); });
purcel.on('close', function(code) { process.exit(code); });
