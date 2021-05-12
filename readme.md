# Strava API Client for ColdBox

## Getting Started

1. Clone this repo - `git clone michaelborn/cbstrava`
2. Copy the .env file - `cp example.env .env`
3. Create a new Strava application by going to https://www.strava.com/settings/api
4. Update the `.env` file with the proper secrets - `vim .env`

Once this is done, you should be ready to utilize cbStrava in your application.

## oAuth Flow

Be aware your app will need to support the full oAuth flow. That means adding an "Authorize Strava" button in your app and implementing a callback API endpoint.

See docs:

https://developers.strava.com/docs/getting-started/