# First Time User Experience (FTUE)

* Issue: https://github.com/syndesisio/syndesis-project/issues/68
* Sprint: 16
* Affected Repos:
  - syndesis-rest
  - syndesis-ui

## Background

The goal of the first time user experience (FTUE) initiative is to provide first users with an optimal experience during the on-boarding process in time for Tech Preview 1.


### Discussion

The purpose of this document is to outline some of the tasks involved in the on-boarding process. These tasks might include, but are not limited to, the following:

1. How to manage registration requests.
2. Providing a single-click installation script for setting new users.
3. Monitoring usage and activity.
4. Providing a de-installation script for off-boarding.
5. Methods of communication with users (e.g. automated emails, mailing lists, forums).
6. A registration page.
7. A feedback form.
8. A guided tour or walk-through for usage of Syndesis.

In theory, this should be broken up into two major stages for first time users:
- **Stage 1**: Signing up to evaluate Syndesis.
- **Stage 2**: Using Syndesis for the first time.


## Stage 1: First Time Registration

This is the very first stage for a first time user and involves the following, which are out of the scope of this epic, but included for reference:
1. Create a Red Hat account.
2. Register for a Syndesis test account, which must be approved manually.
3. An OpenShift account is then created and Syndesis is installed on the user's account.
4. The user receives an email with instructions on how to log into Syndesis using their newly created OpenShift account.


### User Story

TBD as we would like to automate some of this.

- As a first time user, I understand that I need to have created a Red Hat account before requesting a Syndesis account.
- As a first time user, I would like to create an OpenShift Online account and be able to install Syndesis with one click.*
 
 \* In the meantime, users will need to have been granted an OpenShift Online account with Syndesis installed on it, prior to using Syndesis, as this is not currently possible and requires a manual approval and installation.



### First Time Logging in

At the point of login, we would ideally check for pre-existing GitHub configuration settings.
  - **If Settings Exist**: A GitHub user account has been configured already and the user will be redirected to the Get Started page.
  - **If Settings do NOT Exist**: No GitHub user account has been configured and the user will be pushed through the GitHub OAuth flow. This entails the user granting Syndesis with permissions to access their GitHub account. This only needs to be done once.



### REST API

TBD.


---

## Stage 2: First Time Setup and Usage

At this stage, the user is expected to have a registered OpenShift Online account with Syndesis installed. This is where things like proper documentation and a detailed guided tour are essential to providing an optimal first time user experience.

The next step is to create and subsequently connect a GitHub OAuth app to the Syndesis account. We should always programmatically check that the user does not already have one configured.



### User Story

- As a first time user, I would like a clear indication of how to proceed in order to use Syndesis, which includes a link and perhaps brief explanation of how to create a GitHub OAuth App, along with how to connect it to my Syndesis account.
- As a returning user, I would like to be directed to the Getting Started page and skip the GitHub OAuth App creation and guided tour steps.
- As a first time user, I would like clear visual guidance on how to proceed with using Syndesis once my OAuth App is connected, such as with a guided tour (interactive/non-interactive) that educates me on what connections and integrations are, and how to get started with them.
- As a first time user, at any moment, I would like to be able to exit out of the guided tour.
- As a first time user, at any moment, I would like to be able to access/restart the guided tour.
- As a first time user, I would like to have a sample project to start with.
= As a first time user, I would like to be able to delete the sample project once I'm done working with it.
- As a first time user, I would like to have documentation provided throughout my experience in Syndesis, such as through tooltips.
- As a first time user, I would like to be able to provide feedback on my experience as a first time user through something like an interactive survey.



### Setting Up a GitHub OAuth App

The user should be provided with guided instructions (or a link for now) on how or where to create a GitHub OAuth application, preferably in a separate tab or window, as they would not be redirected back to our app.

They will then need to copy and paste the credentials of the GitHub OAuth application into the Syndesis Settings page. 



### Domain

TBD.

### REST API

TBD. Will likely need to pass along a property for the user that lets the UI know whether or not they are a first time user.

**Persisting State**

Steps of the guided tour will not be persisted on the backend. We can store this in the client if necessary.


### UI

**Guided Tour**

If the user is determined to be a first-time user, they will automatically have a guided tour. The user should be able to navigate backwards and forwards, as well as see the total number of steps. The tour should instruct them with the following:

1. How to create a GitHub OAuth App.
2. How to connect it to your Syndesis account (e.g. with credentials).
3. A brief introduction of the dashboard.
4. A brief introduction of the models/components of Syndesis and what they are (e.g. integrations, connections, your profile).
5. Direct them to a sample project they can work with.
6. Advise on how to delete the project once they are done, and possibly how to create a new one of their own. *

\* It gets a bit tricky here, because we don't want to overwhelm the user with too many steps in the tour.

**User Documentation**

Most user documentation will be available via tooltips while the user navigates the application. Tooltips will be pre-generated into the syndesis-ui repo, e.g. as part of the build process. This step will likely require fetching a JSON file from e.g. raw.github.com and then placing it into syndesis-ui repository so that it can be committed.

### Reference

- JIRA: https://issues.jboss.org/browse/IPAAS-339?_sscc=t
- Epic: https://github.com/syndesisio/syndesis-project/issues/68
- Ideas: https://launch.openshift.io/wizard
- Other Idea: https://launch.openshift.io/wizard/launchpad-new-project/1
- UXD issue: https://github.com/syndesisio/syndesis-ux/issues/7
- UI Issue: https://github.com/syndesisio/syndesis-ui/issues/57
- FTUE Journey Map: https://docs.google.com/presentation/d/15vxQIX9TCUXAS8-JLD2m_10TLd0sbFjIMZwW9p0zRww/edit#slide=id.p
- GH user & org design for configuration via global settings: https://github.com/syndesisio/syndesis-ux/issues/29
- GH Settings Designs: https://github.com/syndesisio/syndesis-ux/pull/34

