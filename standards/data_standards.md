# Data standards

We must protect our users' data on every service we work on. In practice this means:

* Only store user data on secure, supported systems
* Test using dummy or obfuscated data wherever possible
* If not possible, mention this in your service's [Data Protection Impact Assessment (DPIA)](https://ico.org.uk/for-organisations/guide-to-data-protection/guide-to-the-general-data-protection-regulation-gdpr/accountability-and-governance/data-protection-impact-assessments/)

## Cookies

Explicit cookie consent is now required when you use "non-essential" cookies on public facing web sites. Analytics cookies are considered non-essential and implied consent is no longer legal. Defra are working with the Government Digital Service and Defra's data protection team on a standard pattern across the organisation. Also, a GOV.UK wide solution is being developed to standardise the process of accepting cookies.

## GitHub

Working in the open means we need to be especially careful with customer data. To minimise the risk of pushing user data to GitHub:

* Avoid downloading any files containing official data to your test repository folder on your machine.
* Add any file extensions that might contain customer data to your `.gitignore` file. Common formats include `.pdf`, `.csv` or `.zip`.

Do not share any environment passwords or login credentials such as Browserstack access keys. Instead, either set up local environment variables containing these passwords (on a Mac, this will usually be in your `.zshrc` file) or include them in a file which is hidden using `.gitignore` .

If data does get compromised then follow the [credential exposure process](../processes/credential_exposure.md).

## Links

[General Data Protection Regulations (GDPR)](https://ico.org.uk/for-organisations/guide-to-data-protection/guide-to-the-general-data-protection-regulation-gdpr/)

[GOV.UK service manual - keeping data secure](https://www.gov.uk/service-manual/technology/securing-your-information)

[GOV.UK - API technical and data standards](https://www.gov.uk/guidance/gds-api-technical-and-data-standards)

[GOV.UK - open standards for government](https://www.gov.uk/government/publications/open-standards-for-government)

[Government data registers](https://www.registers.service.gov.uk/registers)

## Other suggested headings

### Data formats

### Retension and usage

### Database integrity

### Backup and recovery procedures

### Encryption
