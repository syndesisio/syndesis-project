## First Time User Experience (FTUE)

* Issue: https://github.com/syndesisio/syndesis-project/issues/68
* Sprint: 16
* Affected Repos:
  - syndesis-rest
  - syndesis-ui

## Objective

The goal of the first time user experience (FTUE) initiative is to provide first users with an optimal experience during the on-boarding process in time for Tech Preview 1.

The purpose of this document is to outline some of the tasks involved in the onboarding process. These tasks might include, but are not limited to, the following:

1. How to manage registration requests.
2. Providing a single-click installation script for setting new users.
3. Monitoring usage and activity.
4. Providing a de-installation script for off-boarding.
5. Methods of communication with users (e.g. automated emails, mailing lists, forums).
6. A registration page.
7. A feedback form.
8. A walk-through for usage of Syndesis.

In theory, this should be broken up into two major stages for first time users:
- **Stage 1**: Signing up to evaluate Syndesis.
- **Stage 2**: Using Syndesis for the first time.


## Stage 1: First Time Registration

This is the very first stage for a first time user and involves the following, which are out of the scope of this epic, but included for reference:
1. Create a Red Hat account.
2. Register for a Syndesis test account, which must be approved manually.
3. An OpenShift account is then created and Syndesis is installed on the user's account.
4. The user receives an email with instructions on how to log into Syndesis using their newly created OpenShift account.

### First Time Logging in

At the point of login, we would ideally check for pre-existing GitHub configuration settings.
  - **If Settings Exist**: A GitHub user account has been configured already and the user will be redirected to the Get Started page.
  - **If Settings do NOT Exist**: No GitHub user account has been configured and the user will be pushed through the GitHub OAuth flow. This entails the user granting Syndesis with permissions to access their GitHub account. This only needs to be done once.


## Stage 2: First Time Setup & Usage

At this stage, the user is expected to have a registered OpenShift Online account with Syndesis installed. This is where things like proper documentation and a detailed guided tour are essential to providing an optimal first time user experience.

The next step is to create and subsequently connect a GitHub OAuth app to the Syndesis account. We should always programmatically check that the user does not already have one configured.


### Setting Up a GitHub OAuth App

The user should be provided with guided instructions (or a link for now) on how or where to create a GitHub OAuth application, preferably in a separate tab or window, as they would not be redirected back to our app.

They will then need to copy and paste the credentials of the GitHub OAuth application into the Syndesis Settings page. 



