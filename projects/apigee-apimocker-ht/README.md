Mocks on Hosted Targets
---

Lots of mocking examples use Trireme. Here is the Hosted Targets equivalent..

Quick Start

- install nodejs
- obtain an apigee free org

```
export APIGEE_ORG=xxx
export APIGEE_ENV=xxx
export APIGEE_USER=xxx
export APIGEE_PASS=xxx
npm run deploy
npm test
```

You can change the mocks according to:
- https://community.apigee.com/articles/27779/how-to-mock-a-target-backend-with-a-nodejs-api-pro.html
- https://www.npmjs.com/package/apimocker
