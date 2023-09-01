#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { program } = require('commander');

program
  .version('1.0.0')
  .arguments('<projectName>')
  .description('Create a new project in C++')
  .action((projectName) => {
    const projectDir = path.join(process.cwd(), projectName);
    
    if ( fs.existsSync(projectDir) ) {
      console.error(`Error: The project '${projectName}' already exists.`);
      process.exit(1);
    }

    fs.mkdirSync(projectDir);
    fs.mkdirSync(path.join(projectDir, 'inc'));
    fs.mkdirSync(path.join(projectDir, 'lib'));
    fs.mkdirSync(path.join(projectDir, 'obj'));
    // fs.mkdirSync(path.join(projectDir, 'src'));

    // Specify the path to the assets directory
    const assetsDir = path.join(__dirname, 'assets');

    // Copy the Makefile from assets to the project directory
    fs.copyFileSync(path.join(assetsDir, 'Makefile'), path.join(projectDir, 'Makefile'));

    console.log(`Created project '${projectName}' in C++.`);
  });

program.parse(process.argv);
