# Setting up Keycloak All-in-one

This is for testing and integration purposes.

## Start Keycloak 

```
docker run --name=some-keycloak -e DB_VENDOR=h2 -e DB_ADDR= -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=Password123 -p 8080:8080 -itd jboss/keycloak
```

Startup time can take a while. You can check the logs to see progress:
```
docker logs -f some-keycloak
```

You can check everything looks good by logging into the Admin console at 
`localhost:8080` with `admin` and `Password123`.

## Creating a client

You can create a client using the Admin console or using the API.

### Get an Admin Access Token
```
export ADMIN_TOKEN=$(curl \
  'http://localhost:8080/auth/realms/master/protocol/openid-connect/token' \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=Password123' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token')
```

### POST the client
```
curl -v localhost:8080/auth/admin/realms/master/clients \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H 'Content-Type: application/json' -d '@client.json'
```

### Get the generated id for the client
```
export CLIENT_UUID=$(curl \
 'localhost:8080/auth/admin/realms/master/clients?clientId=seans-client' \
 -H "Authorization: Bearer $ADMIN_TOKEN" | jq -r '.[0].id')
```

### Get the generated client secret

```
export CLIENT_SECRET=$(curl \
 "localhost:8080/auth/admin/realms/master/clients/$CLIENT_UUID/client-secret" \
 -H "Authorization: Bearer $ADMIN_TOKEN" | jq -r '.value')

```

### Client Credentials Access Token
```
curl localhost:8080/auth/realms/master/protocol/openid-connect/token -d 'grant_type=client_credentials' -u seans-client:$CLIENT_SECRET | jq
```
