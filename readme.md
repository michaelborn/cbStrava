# Strava API Client for ColdBox

## Getting Started

1. Create a new Strava application by going to https://www.strava.com/settings/api
2. Set the `STRAVA_CLIENT_ID` and `STRAVA_CLIENT_SECRET` environment variables OR `moduleSettings.cbStrava.client_id` and `moduleSettings.cbStrava.client_secret` coldbox settings to configure

Once this is done, you should be ready to utilize cbStrava in your application.

## Configuration

Two options for configuring `cbStrava`:

1. via ColdBox ModuleSettings
2. via environment variables

### ColdBox ModuleSettings

```js
moduleSettings = {
  cbStrava : {
    client_id : "xyz_DO_NOT_SHARE",
    client_secret : "xyz_I_AM_SECRET"
  }
}
```

### Environment Variables

Create a `.env` file and configure the following environment variables. Use Docker or [commandbox-dotenv](https://forgebox.io/view/commandbox-dotenv) to load these environment variables into your ColdBox app.

```bash
STRAVA_CLIENT_ID=xyz_DO_NOT_SHARE
STRAVA_CLIENT_SECRET=xyz_I_AM_SECRET
```

## oAuth Flow

Be aware your app will need to support the full oAuth flow. That means adding an "Authorize Strava" button in your app and implementing a callback API endpoint.

See docs:

https://developers.strava.com/docs/getting-started/

## The Good News

> For all have sinned, and come short of the glory of God ([Romans 3:23](https://www.kingjamesbibleonline.org/Romans-3-23/))

> But God commendeth his love toward us, in that, while we were yet sinners, Christ died for us. ([Romans 5:8](https://www.kingjamesbibleonline.org/Romans-5-8))

> That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved. ([Romans 10:9](https://www.kingjamesbibleonline.org/Romans-10-9/))
 
## Repository

Copyright 2021 (and on) - [Michael Born](https://michaelborn.me/)

* [Homepage](https://github.com/michaelborn/cbStrava/)
* [Issue Tracker](https://github.com/michaelborn/cbStrava/issues?status=new&status=open)

[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/made-with-cfml.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/tested-with-testbox.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/powered-by-coffee.svg)](https://cfmlbadges.monkehworks.com)