# Apigee Drupal 8 Specification Deploy Scripts

Some quick and dirty scripts to delete all specifications from a portal and to 
upload new specifications.

This is intended to be used with [Docker Drupal Kickstart](https://github.com/apigee/docker-apigee-drupal-kickstart), as it has all of the require plugins enabled.

## Usage

Example of quickly setting up a demo:

```
# Prerequisite: start docker drupal kickstart

# Remove demo content
./deleteAllSpecs.sh

# Add my specification
./deploySpec.sh specification.yaml "My API" "A long description of my API"
```

## Known Issues:

`deleteAllSpecs` deletes apidocs from 1..∞ until it receives a 404. This means
it can only be used once, as new APIs will not start from index 1. The is due 
to the lack of a GET /apidocs today on the Drupal REST API.

Cards on the landing page are not updated yet.
