Feature:
  As an API Developer
  I want to add API Key checks
  So that I can have identify clients

  Scenario: Successful Request
    When I GET /get?apikey=`apikey`
    Then response code should be 200
  
  Scenario: Unauthorized Request
    When I GET /get
    Then response code should be 401
