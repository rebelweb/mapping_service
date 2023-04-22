# Mapping Service

A microservice to manage mapping services such as geocoding from Here and Google. The service caches responses from providers using a MongoDB database.

## Endpoints

You can find more information about each endpoint by viewing the build in swagger documentation by starting the server and pointing your browser to __/swager_ui__.

## Configuration Options

The options below are configured as environment variables.


| ENV Variable Name  | Purpose                                                     |
|--------------------|-------------------------------------------------------------|
| HERE_API_KEY       | Key to make requests to Here Maps                           |
| GOOGLE_API_KEY     | Key to make requests to Google Maps                         |
| PREFERRED_PROVIDER | Provider to use by default for requests                     |
| RESPONSE_VALID_FOR | Allows for expiring cached results after a number of days   |
| DATABASE_NAME      | Custom MongoDB Database Name                                |
| DATABASE_HOST      | Custom MongoDB Database Host                                |
| RACK_ATTACK_CACHE  | Rack Attack Cache Server Address                            |
| NUMBER_OF_REQUESTS | Number of Requests allowed within the period                |
| PERIOD_OF_REQUESTS | Number of Seconds for the period for the Number of Requests |
| PUMA_MIN_THREADS   | Mininum number of threads for the Puma App Server           |
| PUMA_MAX_THREADS   | Maximum number of threads for the Puma App Server           |
