# Robot Framework API Automation

## Overview
This project automates API testing using the [Robot Framework](https://robotframework.org/) and [RequestsLibrary](https://marketsquare.github.io/robotframework-requests/). It focuses on testing the [Reqres API](https://reqres.in/) by performing `GET SINGLE USER` and `POST CREATE USER` operations using Python and Gherkin-style test cases.

## Project Structure
```
assignment-1/
│── resources/
│   ├── keywords/
│   │   ├── create_user_keywords.resource  # Keywords for creating a user
│   │   ├── get_user_keywords.resource     # Keywords for retrieving a user
│   ├── variables/
│   │   └── user_variables.resource        # Global variables
│── tests/
│   ├── features/
│   │   ├── create_user.feature            # Feature file for creating a user
│   │   ├── get_user.feature               # Feature file for retrieving a user
│   ├── step_definitions/
│   │   ├── create_user_steps.robot        # Step definitions for creating a user
│   │   ├── get_user_steps.robot           # Step definitions for retrieving a user
│── README.md                               # Project documentation
│── requirements.txt                        # Dependencies
```

## Prerequisites
1. Install [Python](https://www.python.org/downloads/)
2. Install Robot Framework:
   ```sh
   pip install robotframework
   ```
3. Install RequestsLibrary:
   ```sh
   pip install robotframework-requests
   ```
4. Ensure all dependencies are installed by running:
   ```sh
   pip install -r requirements.txt
   ```

## Test Cases
### 1. Get Single User
**File:** `tests/features/get_user.feature`
**Description:** Retrieves details of a single user from the Reqres API.

**Gherkin-style Steps:**
```gherkin
Scenario: Successfully retrieve user details
  Given I have a valid user ID
  When I request the user details
  Then the response status should be 200
  And the user details should match expectations
```

### 2. Create New User
**File:** `tests/features/create_user.feature`
**Description:** Creates a new user using a POST request to the Reqres API.

**Gherkin-style Steps:**
```gherkin
Scenario: Successfully create a new user
  Given I provide valid user details "Hanif" and "Afianto"
  When I send a request to create a user
  Then the response status should be 201
  And the user should be created with the correct details
```

## Running the Tests
Run all tests using:
```sh
robot tests/
```
Run a specific test:
```sh
robot tests/step_definitions/get_user_steps.robot
```
Run tests with logs and reports:
```sh
robot --outputdir results tests/
```

## Reports & Logs
- **Execution Report:** `results/report.html`
- **Log File:** `results/log.html`

## Contributing
- Follow best practices for Robot Framework test writing.
- Maintain consistency in Gherkin-style formatting.
- Ensure tests are independent and reusable.