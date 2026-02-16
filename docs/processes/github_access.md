# GitHub access

This guide covers covers all things related to accessing and using [GitHub](https://github.com) in the context of working on a Defra project.

## GitHub account requirements

Before you can do anything on GitHub you'll need to [create an account](https://github.com/join). If you already have one it is okay to use it, else create a new one specifically for your Defra work if you prefer.

Whether you create an account or use an existing one, it must meet the following requirements

- [Two factor authentication](https://help.github.com/articles/about-two-factor-authentication/) must be enabled
- Your profile must have the `Name` field populated with your full name .e.g. *Alan Cruikshanks*.

You're not required to set a profile picture, but changing it from the default GitHub provides will help your team members distinguish your contributions from theirs.

## Joining a Defra organisation

All projects at Defra must be created under one of the organisations within the Defra GitHub enterprise:

- [Defra](https://github.com/DEFRA) for development of digital services
- [Defra Data Science Centre of Excellence](https://github.com/Defra-Data-Science-Centre-of-Excellence) for data science
- [Defra design team](https://github.com/defra-design) for prototype designs
- [aphascience](https://github.com/aphascience) for scientific projects at APHA

The organisation owners can be contacted to add you to their organisation:

- for digital service development or design, use the #github-support channel on the Defra Digital Slack workspace
- for data science visit the [Internal Defra DASH SharePoint site](https://defra.sharepoint.com/sites/Community448) for contact details
- for scientific projects at APHA visit the [Internal Defra SCE SharePoint site](https://defra.sharepoint.com/teams/Team741) for contact details

Depending on your role and requirements, you may either be added as a member of the organisation or as an [outside collaborator](https://help.github.com/articles/adding-outside-collaborators-to-repositories-in-your-organization/) on individual repositories.

## Getting a new repository

You should contact the organisation owners to create a new repository. They'll need

- A name for the repository - this should be consistent with the existing organisational naming conventions
- Whether the repository is to be private or public - and if it is private the [justification](https://www.gov.uk/government/publications/open-source-guidance/when-code-should-be-open-or-closed) for this
- The GitHub team or username of the person that will be its administrator
- (Optional) A description - having a short description helps other people quickly identify what is in your repository
- (Optional) The language you will be coding with - this allows us to pre-populate your repository with a suitable `.gitignore` file, which can help prevent accidentally committing sensitive information

**Do not create repositories under your own user account!** Though repositories can be transferred at a later date, it is easier for everyone if they originate within our organisations.

## Analysing a repository with SonarQube Cloud

If your repository is in the Defra GitHub organisation, we have a SonarQube Cloud organisation that can be used to perform static analysis on your code.

You should put this in place, to ensure that you comply with [our standard for code quality checks](../standards/common_coding_standards.md/#all-code-is-checked-for-quality).

To request this, you can contact the organisation owners:

- use the #sonar-support channel on the Defra Digital Slack workspace

You will need to [sign in to SonarQube Cloud](https://sonarcloud.io/login) with your GitHub account before you can be added to the Defra SonarQube Cloud organisation.

## Administering a repository

If you are the administrator for a repository it's your responsibility to ensure the repo has been set up and maintained in accordance with the standards of the organisation.

Depending on the organisation settings, you may be able to create and maintain teams to help with administering who has access to your repositories. If not, you may still be able to request the creation of teams from your organisations owners.

However you choose to manage it, you must always ensure that your repository's **Collaborators and teams** setting accurately reflects who should have access to the repository.

If you will no longer be the administrator for a repository, you will need to identify a replacement and make them the administrator.

## Archiving repositories

When a repository that you administer is no longer being maintained, you should request that it be archived. This can be done by contacting the relevant organisation owners.

We typically archive repositories rather than deleting them, as the code they contain may still be of value.

Repositories without an administrator will be archived by the organisation owners.

Repositories that have been inactive for 24 months or more will be archived by the organisation owners.

If an archived repository has an associated SonarQube Cloud project then that will be deleted by the organisation owners. Projects will also be deleted if they haven't been analysed for 24 months or more.

## Access removal

Each month, the administrators of our Defra GitHub enterprise will run a report to identify any [dormant users](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-accounts-and-repositories/managing-users-in-your-enterprise/managing-dormant-users) who have not been active for six months and provide the list to each of the organisation owners in the enterprise.

The organisation owners will remove those users from their organisation, or identify to the enterprise owners any accounts that should be retained.

This will ensure that we are using our licences effectively and that we are applying appropriate security controls on our information.

If you need access again after your account is removed, you will need to ask to join an organisation again as described above. The organisation owners can reinstate the permissions you had before removal if you request to rejoin within three months of being removed.

If you think you may be identified as a dormant user, for example if you are taking an extended break from work, then you should let an organisation owner know and they will ensure that your account is not removed.

## Getting a new organisation

If you would like to have a new organisation added into the Defra enterprise you should contact one of the enterprise administrators to discuss your requirements.

## Owning an organisation

As an organisation owner you are responsible for

- setting the standards and processes for access control in your organisation
- removing dormant users from your organisation
- informing enterprise owners of any dormant users who still require access
- ensuring that people that will want to join your organisation know who you are and how to contact you
