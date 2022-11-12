# Mapping Service

A microservice to manage mapping services such as geocoding from Here and Google. The service has a built in caching system to reduce API calls to providers. The cache system uses MongoDB for data storage.

## Endpoints

### GET /geocoding

Retrieves address and geopositioning data for a given query

__Params__
- query - search query to get information for
- provider (optional) -  provider to get data from

### GET /status

Returns information about the microservice including version, default provider, and configured providers.

## Configuration Options

The options below are configured as environment variables.

### HERE_API_KEY

This is the API to use the HERE provider

### GOOGLE_API_KEY

This is the API to use the Google provider

### PREFERRED_PROVIDER

This is the name of the provider to use by default.

### RESPONSE_VALID_FOR

Allows for expiring cached results after a number of days
