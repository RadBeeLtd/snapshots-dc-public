# Script Usage Guide

## 1. **Overview**
- This script sends POST requests to a specified JIRA URL with a JSON payload.
- The JSON body uses a parameter (referred to as "JQL") from a list of lines in a file in a round-robin fashion.

## 2. **Prerequisites**
- Ensure you have `bash` and `curl` installed on your system.
- The script assumes you have a file with one JQL parameter per line that will be used as input for the JSON payload.

## 3. **Script Parameters**
- `JQLs_FILE`: The path to the file containing the JQL parameters (one per line).
- `JIRA_URL`: The endpoint where the POST request will be made, e.g., `https://radbee-jira.radbeedev.com` (Do not include a trailing slash).
- `USERNAME`: The username for basic authentication.
- `PASSWORD`: The password for basic authentication.

## 4. **Usage**
- Download script `jira_jql_search_script.sh` from that repository
- Make it executable
  ```bash
    chmod +x jira_jql_search_script.sh
  ```
- Download file with JQL examples, fix it if needed
- Execute the script using the following command:
  ```bash
  ./jira_jql_search_script.sh <JQLs_FILE> <JIRA_URL> '<USERNAME>' '<PASSWORD>'
- Provide the appropriate arguments for `<JQLs_FILE>`, `<JIRA_URL>`, `<USERNAME>`, and `<PASSWORD>`.

## 5. **Example**
- Assuming:
    - The JIRA URL is https://radbee-jira.radbeedev.com.
    - The username is user123.
    - The password is pass456.
    - Your JQL parameters are listed in `jqls.txt`.
- Run
  ```bash
  ./jira_jql_search_script.sh jqls.txt https://radbee-jira.radbeedev.com user123 pass456
  ```  

## 6. **Output**
- The script will display:
    - Request number.
    - HTTP status code from the server's response.
    - Execution time of the request in seconds.
    - The first 100 characters of the server's response body.
- Example
  ![Alt text](<CleanShot 2023-11-02 at 11.57.59@2x-1.png>)
