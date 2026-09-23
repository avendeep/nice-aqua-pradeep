Feature: Test Login API
  Validate the login API for accounts with and without MFA, and handle various error conditions.

  Background:
    Given the API base URL is set
    And I have a valid authentication token

  @TS-TEST-17
  @TC-LOGIN-001
  @dryrun
  Scenario: TC1: Successful login with MFA disabled
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 200
    And the response field "status" should be "true"
    And the response field "message" should be "Login successful"
    And the response field "data.mfa_required" should be "false"
    And the response field "data.access_token" should not be null

  @TS-TEST-17
  @TC-LOGIN-002
  Scenario: TC2: Successful login with MFA enabled
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 200
    And the response field "status" should be "true"
    And the response field "message" should be "MFA verification required"
    And the response field "data.mfa_required" should be "true"
    And the response field "data.pre_auth_token" should not be null

  @TS-TEST-17
  @TC-LOGIN-003
  Scenario: TC3: Login with valid email and incorrect password
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 401
    And the response field "status" should be "false"
    And the response field "message" should be "Invalid email or password"

  @TS-TEST-17
  @TC-LOGIN-004
  Scenario: TC4: Login with non-existent email
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 401
    And the response field "status" should be "false"
    And the response field "message" should be "Invalid email or password"

  @TS-TEST-17
  @TC-LOGIN-005
  Scenario: TC5: Login attempt with missing password field
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"

  @TS-TEST-17
  @TC-LOGIN-006
  Scenario: TC6: Login attempt with missing email field
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"

  @TS-TEST-17
  @TC-LOGIN-007
  Scenario: TC7: Login attempt with invalid email format
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"

  @TS-TEST-17
  @TC-LOGIN-008
  Scenario: TC8: Login attempt with empty string for email
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"

  @TS-TEST-17
  @TC-LOGIN-009
  Scenario: TC9: Login attempt with empty string for password
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"

  @TS-TEST-17
  @TC-LOGIN-010
  Scenario: TC10: Login attempt with malformed JSON body
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422

  @TS-TEST-17
  @TC-LOGIN-011
  Scenario: TC11: Login attempt with null request body
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422

  @TS-TEST-17
  @TC-LOGIN-012
  Scenario: TC12: Login attempt with empty JSON object body
    When I send a "POST" request to "/api/v1/auth/login"
    Then the response status code should be 422
    And the response field "message" should be "Validation failed"
