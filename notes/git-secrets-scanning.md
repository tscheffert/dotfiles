# Notes on Git Secrets Scanning

## Premise

Sometimes we put secrets into our git history! We can easily remove them with something like [BFG](https://rtyley.github.io/bfg-repo-cleaner/), but how do we find them?

Lots of different options. These notes detail my research.

Note: Most of the options will be things that are viable for use, so commercial offers usually aren't included

## Options:

- [Blog post with good summary](https://www.eneigualauno.com/security/2022/03/25/secret-scanners.html)
- GitHub Advanced Security for Azure DevOps Services
  - Paid github offering

Leverages multiple tools:

- [Microsoft Security DevOps Azure DevOps Extension](https://learn.microsoft.com/en-us/azure/defender-for-cloud/azure-devops-extension)
  - Composes a ton of other tools
- [Secret Magpie by Punk Security](https://github.com/punk-security/secret-magpie)
  - CLI leveraging Trufflehog and GitLeaks to scan repo organizations

Standalone:

- [GitLeaks](https://github.com/gitleaks/gitleaks)
  - Seems very popular
  - Run from brew or docker
- [trivy by aquasecurity](https://github.com/aquasecurity/trivy)
  - Does a TON of stuff
  - For more than git credential leaks
  - Seems active and powerful
- [terrascan by tenable](https://github.com/tenable/terrascan)
  - Scans a ton of stuff
  - For more than git credential leaks
  - Uses rego!
- [trufflehog by trufflesecurity](https://github.com/trufflesecurity/trufflehog)
  - Scans some stuff
  - Primarily for git credential leaks
  - Complicated to run
  - Makes a bunch of web requests against their servers

- [CodeQL by GitHub](https://codeql.github.com/docs/)
  - semantic code analysis engine to query code as data
  - Lots of languages/frameworks supported
  - Not sure if any built in rules

- [detect-secrets by Yelp](https://github.com/Yelp/detect-secrets)
  - Simple python scripts
  - Pip install
  - Not as commonly mentioned
- [Talisman by Thoughtworks](https://github.com/thoughtworks/talisman)
  - Not as popular
  - Bash script install magic
  - Relatively complicated
- [git-secrets by awslabs](https://github.com/awslabs/git-secrets)
  - Doesn't seem very up to date


Other:

- [Secrets Patterns DB](https://github.com/mazen160/secrets-patterns-db)
  - Giant yaml file of regex patterns extracted from other secret scanning tools
