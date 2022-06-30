#!/bin/bash 

#Check if option exists 
if [ -z "$1"]
    then
        echo "Module name has to be provided"
        exit 1
else
if [ "$1" = "--database" -o "$1" = "-d" ];
then
    echo "Module name has to be provided"
    exit 1
else

mkdir $1
cd $1
npm init -y

mkdir "routes"

#check for option
if [ "$2" = "--database" -o "$2" = "-d" ]; then

#add database files
echo "const express = require('express')
const app = express()
const PORT = process.env.PORT || 8000

app.use(express.json())
app.use(express.urlencoded({extended: true}));
require(\"./config/database_connection\")();

app.get(\"/\", (req, res) => {

    res.send(\`Server running on port \${PORT}\`)
})

app.listen(PORT, () => {
    console.log(\`Server is running on port \${PORT}\`);
});" > "index.js"

#exporting config file for mongodb
mkdir "config"
mkdir "models"

echo "const mongoose = require(\"mongoose\");

function ConnectMongoDBDatabase() {
    console.log(\"Connecting to database...\")

    //TODO: change database connection string
    const databaseConnection = mongoose.connect(\"mongodb://localhost/$1\");

    databaseConnection.then(() => {
        console.log(\"Connected to mongoDB database successfully\");
    });
    databaseConnection.catch((error) => {
        console.log(\"Database connection refused\", error);
    });
}

module.exports = ConnectMongoDBDatabase;
" > "config/database_connection.js"

npm install mongoose --save

else
#ignore database files
echo "const express = require('express')
const app = express()
const PORT = process.env.PORT || 8000

app.use(express.json())
app.use(express.urlencoded({extended: true}));

app.get(\"/\", (req, res) => {

    res.send(\`Server running on port \${PORT}\`)
})

app.listen(PORT, () => {
    console.log(\`Server is running on port \${PORT}\`);
});" > "index.js"
fi


npm install express --save
#add gitignore
echo "# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*

# Diagnostic reports (https://nodejs.org/api/report.html)
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov

# Coverage directory used by tools like istanbul
coverage
*.lcov

# nyc test coverage
.nyc_output

# Grunt intermediate storage (https://gruntjs.com/creating-plugins#storing-task-files)
.grunt

# Bower dependency directory (https://bower.io/)
bower_components

# node-waf configuration
.lock-wscript

# Compiled binary addons (https://nodejs.org/api/addons.html)
build/Release

# Dependency directories
node_modules/
jspm_packages/

# Snowpack dependency directory (https://snowpack.dev/)
web_modules/

# TypeScript cache
*.tsbuildinfo

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Optional stylelint cache
.stylelintcache

# Microbundle cache
.rpt2_cache/
.rts2_cache_cjs/
.rts2_cache_es/
.rts2_cache_umd/

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variable files
.env
.env.development.local
.env.test.local
.env.production.local
.env.local

# parcel-bundler cache (https://parceljs.org/)
.cache
.parcel-cache

# Next.js build output
.next
out

# Nuxt.js build / generate output
.nuxt
dist

# Gatsby files
.cache/
# Comment in the public line in if your project uses Gatsby and not Next.js
# https://nextjs.org/blog/next-9-1#public-directory-support
# public

# vuepress build output
.vuepress/dist

# vuepress v2.x temp and cache directory
.temp
.cache

# Docusaurus cache and generated files
.docusaurus

# Serverless directories
.serverless/

# FuseBox cache
.fusebox/

# DynamoDB Local files
.dynamodb/

# TernJS port file
.tern-port

# Stores VSCode versions used for testing VSCode extensions
.vscode-test

# yarn v2
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
.idea
" > ".gitignore"
fi
fi