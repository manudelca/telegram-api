#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login and set env var SUMOLOGIC_SOURCE!!!!

set -e

# heroku login

APP_NAME=webapi-volantis-test

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=production --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE_TEST --app $APP_NAME
