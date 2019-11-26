Feature:
  As a third party
  I want to obtain an access token
  So that a user can delegate access for my application for a limited time
  and scope

  Scenario: Successful Request
    Given I have basic authentication credentials seans-client and password
    And I set form parameters to
	    | name	    	| value			          |
    	| grant_type	| client_credentials	|
    When I POST to /auth/realms/master/protocol/openid-connect/token
    Then response code should be 401
	
  Scenario: Successfully /ping
    When I GET /ping
    Then response code should be 200
	
  Scenario: Successfully /status
    When I GET /status
    Then response code should be 200

  Scenario: Successfully /authorize   
    Given I set query parameters to
      | parameter     | value             |
      | client_id     | `validClientId`   |
      | redirect_uri  | `validRedirectUri`|
      | response_type | code              |
      | scope         | openid            |
      | state         | `generatedState`  |
    And I generate a request JWT
    When I GET /authorize
    Then response code should be 200
    And response header Content-Type should be application/html
    And response body should contain <form name="login">
  
  Scenario: Successfully obtain an authorization code
    Given I navigate to the authorize uri
    When I sign in and consent
    Then I am redirected to `validRedirectUri`
    And I receive an authorization code in a query param
    And I receive a valid state
    And I store the authorization code in global scope

  Scenario: Successfully /token
    Given I have basic authentication credentials `validClientId` and `validClientSecret`
    And I set form parameters to
      | parameter   | value                   |
      | client_id   | `validClientId`         |
      | grant_type  | authorization_code      |
      | code        | `authCode`              |
      | redirect_uri| https://httpbin.org/get |
    When I POST to /identity/v1/token
    Then response code should be 200
    And I store the value of body path $.access_token as userToken in global scope

  Scenario: Successfully make a protected request
    Given I set Authorization header to Bearer `userToken`
    When I GET /resource
    Then response code should be 200


