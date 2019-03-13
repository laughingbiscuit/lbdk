# Apigee Identity

Here are some examples of how Identity APIs can be implemented within Apigee.

The main considerations for these examples are:
- Are we using an external identity provider or leveraging Apigee built in policies?
- Where are Client Credentials stored?
- Where are User Credentials stored?
- Where are tokens managed?
- Where are login and consent pages managed?

## Apigee Entities

``` txt

                      | Developer   |
                      |-------------|
                      | email       |
                      |-------------|
                          1 |          \*
                            |           \1
                          * |        
  | Key + Secret  |---| Develop App |---| Company       | 
  |---------------|1 1|-------------|   |---------------|
                      | callback url|   | billing info  |
                      |-------------|   |---------------|
                          * |        * 1
                            |
                          * |        
                      | API Product     |
                      |-----------------|
                      | allowed scopes  |
                      | environments    |
                      | visibility      |
                      |-----------------|
                          * |       
                            |
                          * |        
                      | API Proxy       |
                      |-----------------|
                      | required scopes |
                      |-----------------|
```          

## Identification - API Keys

API Keys can be used to identify an Application that is calling an API. They __will__ be accidentally committed to source control. They __will__ be stolen from public clients or decompiled mobile apps. Their main purpose is to identify clients for analytics, rate-limiting and on some occasions Access Control purposes.

__If Apps are managed in Apigee__
- Developer Portal onboarding will work out of the box
- Analytics Reports including Developer Engagement and App dimensions in custom reports will work out of the box

Deploy a proxy with a verify API key policy
``` bash
npm run deploy --prefix apikey-example-v1
```

Create an API Product containing that proxy
``` bash
curl https://api.enterprise.apigee.com/v1/o/$APIGEE_ORG/apiproducts -u $APIGEE_USER:$APIGEE_PASS -H 'Content-Type: application/json' -d '{ "name" : "example-product", "displayName": "Example Product", "approvalType": "auto", "apiResources": [ "/", "/**" ], "environments": [ "test" ],   "proxies": [] }' -v
```

Create a developer in the UI or by Mgmt API
``` bash
curl https://api.enterprise.apigee.com/v1/o/$APIGEE_ORG/developers -u $APIGEE_USER:$APIGEE_PASS -H 'Content-Type: application/json' -d '{ "email" : "doctor@example.com", "firstName" : "Doctor", "lastName" : "Who", "userName" : "doctor@example.com" }' -v
```

Then create a developer app for the developer
``` bash
curl https://api.enterprise.apigee.com/v1/o/$APIGEE_ORG/developers/doctor@example.com/apps -u $APIGEE_USER:$APIGEE_PASS -H 'Content-Type: application/json' -d '{ "name" : "SonicApp", "apiProducts": [ "example-product" ] }'
```

Get the API key for that developer app
```bash
./getKey.sh
```
Try it ourselves whilst running a trace
```bash
# using our cucumber tests
APIKEY=$(./getKey.sh) npm test --prefix apikey-example-v1

#manually with curl
curl https://$APIGEE_ORG-$APIGEE_ENV.apigee.net/apikey-example/v1/get?apikey=$(./getKey.sh)
```
