# Howlr

This is the source code of the server used by Howlr. It is a pretty basic Ruby on Rails application and it exposes a GraphQL API to the [mobile app](https://github.com/howlrapp/howlr-app).

We made a few changes to make it simpler, it is also easier and cheaper to deploy:

* When we started building Howlr we wanted the server to be able to handle multiple apps, it never really worked though and made the code a bit more complicated, so here we removed this feature.
* We merged the moderation and admin interface. It is now way simpler to maintain.
* We previously used a separate server for reverse geocoding, for this release we decided to merge it with the rest of the Howlr code base to make it simpler to deploy.
* We added a way to store files locally instead of having to use an external service like S3 (though it is still possible).
* We removed all the dead code and other features we never really used.

# Deployment

For this tutorial we are using a cheap 2GB DEV1-S instance from [Scaleway](https://www.scaleway.com/) with Ubuntu 20.04. We will also use [Dokku](https://dokku.com/) which is a very simple layer over Docker that makes it easier to administrate and deploy your services using Git (just like [Heroku](https://heroku.com), but on your own server), to generate certificate with Letsencrypt and to upload encrypted database backups to S3. If you don't want to use Dokku you can still follow those steps for you own setup.

We also assume that you are logged in as `root`.

## Dokku

There are a few good reasons to use Dokku:

* While it is pretty easy to use and is well documented it still forces you to go through a few simple steps before you application is up and running, and we think it is important to know and understand those steps.
* You can use it on commodity hardware and cheap servers, because if you plan to run your own Howlr server we think it is important that it doesn't become a financial burden.
*  We think it's a really neat project that deserves more attention.

Please follow the installation instructions [on the Dokku documentation](https://dokku.com/docs/getting-started/installation/#installing-the-latest-stable-version) to install the latest version of Dokku.

After the installation is complete, you must add your SSH public key:

```
echo YOUR_SSH_PUBLIC_KEY | dokku ssh-keys:add admin
```

You should also set a global domain for your server, though it's not mandatory for now:

```
dokku domains:set-global my-app.com
```

## Create your app

Deploying with dokku is very similar to deploying with Heroku: Dokku exposes a git repository and uses git hooks and `buildpacks` to install your project dependencies and run all necessary tasks. It also handles zero-downtime deployment for you.

First we need to create our Dokku app:

```
dokku apps:create my-app
```

## PostGIS

Our next step will be to install PostGIS using Dokku and the Postgres plugin [https://github.com/dokku/dokku-postgres](https://github.com/dokku/dokku-postgres).

First we need the dokku-postgres plugin:

```
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
```

We then need to create a PostgresSQL container using the `mdillon/postgis` image:

```
export POSTGRES_IMAGE="mdillon/postgis" 
export POSTGRES_IMAGE_VERSION="latest"
dokku postgres:create my-database
```

The final step is to link our PostgresSQL server to our newly created app:

```
dokku postgres:link my-database my-app
```

Don't worry if you see something like `App image (dokku/my-app:latest) not found` in the logs, it is because we haven't deployed the app yet.

*Linking will expose the PostgreSQL service in our app container and add the DATABASE_URL environment variable with all the required info for our app to connect to the database.*


We also suggest you to read the plugin [README](https://github.com/dokku/dokku-postgres/blob/master/README.md) if you want to setup (encrypted) backups.

## Redis

You will need redis to handle push updates. Install the [dokku-redis](https://github.com/dokku/dokku-redis) plugin:

```
sudo dokku plugin:install https://github.com/dokku/dokku-redis.git redis
```

Then you can create your Redis server with:

```
dokku redis:create my-redis
```

Just like with PostgreSQL we need to link the Redis server to our app:


```
dokku redis:link my-redis my-app
```
 
*This will expose the REDIS_URL environment variable with all the required info for our app to connect to Redis.*


## Configuration

We then need to configure our app, Dokku uses environment variables for that.

### Host

For everything to work correctly you must tell your app about its hostname.

```
dokku config:set my-app HOST=my-app.com
```

### Secret key

`SECRET_KEY_BASE` is the main cryptographic key used to encrypt message and image paths, you can generate one by running:

```
dokku config:set my-app SECRET_KEY_BASE=`openssl rand -hex 64`
```

*This key MUST never be shared. You should also make sure that you keep a backup somewhere, if you lose it all private messages and images will become unusable.*

### Freegeoip

When users first sign up on Howlr we want to give them a decent default location based on their IP address, for that we use the service of [Freegeoip](https://freegeoip.app/). This service is free for less than 15 000 requests/hours (which is probably more than enough for your needs, otherwise... good luck) but you still have to sign up and get an API key.

```
dokku config:set my-app FREEGEOIP_API_KEY=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
```

### File storage

#### On the server

Storage on Dokku is ephemeral, meaning everything you save will be deleted at the next reboot, luckily you can expose a local directory as persistent storage in your app container.

More documentation available at https://dokku.com/docs/advanced-usage/persistent-storage/.

To expose a local directory you can use the following command:

```
# Create a local directory to use for persistent storage
dokku storage:ensure-directory my-app

# Then mount it in your container
dokku storage:mount my-app /var/lib/dokku/data/storage/my-app:/app/public/uploads
```

*Notes: if you're tight on disk space you can set the environment variable `REMOVE_ORIGINAL_FILE=true` to automatically remove the original file and only keep the resized files.*

#### On S3 (or S3-compatible)

Howlr can store files on any S3-compatible service like Minio, or of course AWS S3.

```
dokku config:set my-app S3_ACCESS_KEY_ID=XXX
dokku config:set my-app S3_SECRET_ACCESS_KEY=XXX
dokku config:set my-app S3_BUCKET=XXX
dokku config:set my-app S3_REGION=XXX

# For Minio set it to "localhost", otherwise don't set it
dokku config:set my-app S3_HOST=XXX

# Set it if you're not using Amazon S3, otherwise don't set it
dokku config:set my-app S3_ENDPOINT=XXX
```

#### CDN

If you plan to use a CDN like Amazon Cloudfront you set it with `ASSET_HOST`:

```
dokku config:set my-app ASSET_HOST=https://my-cloudfrond-endpoint.aws.com
```

## Set domain

```
dokku domains:set my-app my-app.com
```

*Don't worry if you see something like `No web listeners specified for my-app`, it is because we haven't deployed our app yet.*

Please follow the Dokku documentation here https://dokku.com/docs/configuration/domains/ if you wish to do more complicated things, like settings multiple domains.


### Letsencrypt

You can enable Let's encrypt for your domain(s) with the [LetsEncrypt plugin](https://github.com/dokku/dokku-letsencrypt) for Dokku:

```
# Install the plugin
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git

# Set your email address to get notified when your certificate expires (this step is mandatory)
dokku config:set --no-restart my-app DOKKU_LETSENCRYPT_EMAIL=your@email-address.com

# Generate and enable letsencrypt on your app
dokku letsencrypt:enable my-app
```

You should also add a cron job to auto renew your certificate:

```
dokku letsencrypt:cron-job --add
```

## First deploy

First, you need to clone this repository:

```
git clone git@github.com:howlrapp/howlr-server.git
```

Just like Heroku, Dokku uses git to handle deployment, first set your server as a git remote:

```
git remote add server dokku@my-app.com:my-app
```

And everytime you want to deploy you just have to push to this remote:

```
git push server main:master
```

If you're really tight on memory and you can accept a few seconds of downtime on each deploy you
can also completely disable zero-downtime deployment:

```
dokku checks:disable my-app web,worker
```

### Create and populate the database

Our database is still empty, to create the schema run the following command:

```
dokku run my-app bin/rake db:schema:load
```

If you wish to setup all the genders, sexual orientations and groups that Howlr had, you can run the following command:

```
dokku run my-app bin/rake db:populate
```

#### Geocoding

You can find a dump of our geographic data here: https://drive.google.com/file/d/11uuodrOxMbA4GAl7fyOEH2Co-htwSb4q/view?usp=sharing

Once downloaded and uncompressed you can upload it to your server and restore it with the following command:

```
dokku postgres:connect my-database < ./geowlr.dump
```

It will take a while, it's probably a good time to grab a coffee, or hug your cat.

### Create an admin 

To create your first administrator we need to run the Rails console, don't worry it's not that scary:

```
dokku run my-app rails c
```

After a few second you should see the console prompt, to create an admin user you can write:

```ruby
AdminUser.create!(email: "your.email@address.com", password: "your_password")
```

Press `ctrl+D` or `cmd+D` to exit the console.

Now you can go [https://my-app.com/admin](https://my-app.com/admin) and sign-in to the admin interface.

## Telegram Bot

Howlr uses a Telegram bot to handle user registration, to configure it you must first talk to [@botfather](https://t.me/botfather) and follow their instruction. Once your bot is created you can reference it in Howlr with the following environment variables:

```
dokku config:set my-app CODE_BOT_USERNAME="MyAppLoginBot"
dokku config:set my-app CODE_BOT_TOKEN="telegram:token"
```

Once this is done we must set a webhook on Telegram, you can do that by running the following command:

```
dokku run my-app bin/rake telegram:bot:set_webhook
```

You can then send `/start` to your bot to make sure everything is working fine.


## Sign-up code for Apple

If you plan to release your app on iOS you will need to generate a special sign-up code for the Apple reviewer because they won't use Telegram. To achieve that you use the `APPLE_SIGN_UP_CODE` environment variable, to generate a sign-up code use the following command:

```
dokku run my-app bin/rake users:generate_apple_sign_up_code
```

And set the environment variable in your application:

```
dokku config:set my-app APPLE_SIGN_UP_CODE=YOUR_GENERATED_SIGN_UP_CODE
```

When a Apple reviewer use this code, a new user and session will be created for them the first time they sign-up, this user will have a special their telegram_id set to `apple_reviewer` if you want to find it in your database.

## Configure the mobile app

It's pretty simple, after you fetch the [source code of our mobile app](https://github.com/howlrapp/howlr-app) you just have to open [app.json](https://github.com/howlrapp/howlr-app/blob/main/app.json) and change the `productionApiUrl` and `productionCableUrl` to match your need:

```
{
	[other stuff...]

	"productionApiUrl": "https://my-app.com/graphql",
	"productionCableUrl": "wss://my-app.com/cable",
	
	[more stuff...]
}
```

# Development

Howlr is not a big project, less than 2500 lines of very declarative code (and around 700 more for the admin interface and 4000 for the tests). Hopefully it should be pretty easy to get a grasp on it if you already have some experience with Ruby on Rails.

### Dependencies

`apt-get install ruby build-essentials libxml2-dev libxslt-dev libz-dev postgresql`

You will also need a running PostgreSQL server (with PostGIS).

You can install all Ruby dependencies by running `bundle install` at the project's root directory.

### Database

Create and setup the database schema with:

`bin/rake db:create db:schema:load`

If you want to build a service similar to Howlr you can populate the database will all groups, sexual orientations, etc, that we had:

`bin/rake db:populate`

If you also want to populate your database with fake data you can use the following command:

```
# This will create 100 users
USERS_COUNT=100 bin/rake db:seed
```

*The seed is very slow, but we recommend you create at least 100 users.*

#### Geocoding

You can find a dump of our geographic data here: https://drive.google.com/file/d/11uuodrOxMbA4GAl7fyOEH2Co-htwSb4q/view?usp=sharing

Once downloaded and uncompressed you can restore it with the following command:

```
cat ./geowlr.dump | psql howlr_development
```

### Configuration

#### Environment variables

Some aspect of Howlr are controlled with environment variables, in development you can copy [`config/application.yml.sample`](config/application.yml.sample) to `config/application.yml` and change things as you want.

```
cp config/application.yml.sample config/application.yml
```
*Note that `config/application.yml` is gitignored and shouldn't be versionned.*

You can also take a look at [`config/application.rb`](config/application.rb) and other files in the `config/` directory to see how and when those environment variables are used.

### Run the server

```
bin/rails s
```

You can also specify the port and host:

```
bin/rails s -p 3010 -b 192.168.1.70
```

### Configure the mobile app

Same thing as what we did for deployment, just with different keys:

```
{
	[other stuff...]

	"developmentApiUrl": "http://localhost:3000/graphql",
	"developmentCableUrl": "ws://localhost:3000/cable",
	
	[more stuff...]
}
```

# Karma

Howlr uses a karma system to evaluate if a given user should be made visible to other users. Everybody starts with a karma of `0` and anybody whose karma falls under `KARMA_LIMIT`(which is `-8` by default) will be invisible to other users until their karma goes up.

Karma rules can be written in plain Ruby and are configurable at `config/initializers/karma.rb`. There are already a few rules given as example, if you want to add a new rule you just have to add a karma modifier in the `rules` hash.

This function has full access to the Rails environment, meaning you can make any query you want, access the whole user object, etc.

*In the admin interface you can manually boost (with a positive) or aggravate (with a negative value) the karma of individual users.*

Bisous les louloups !
