# My Privacy DNS Matrix

[![My Privacy DNS](https://www.mypdns.org/images/logo.png)](https://www.mypdns.org/)

## Introduction

My Privacy DNS is an organisation dedicated to maintaining a comprehensive
knowledge base on blacklisted domains across various DNS blacklist projects. Our
primary goal is to collect and organise this information to provide clear
insights into why certain domains are blacklisted. The secondary objective is to
offer these blacklists through the Matrix repository as a direct reflection of
the data gathered
from [kb.mypdns.org/issues/MTX](https://kb.mypdns.org/issues/MTX), Matrix
issues,
and [mypdns.youtrack.cloud/issue/MTX](https://mypdns.youtrack.cloud/issue/MTX).

## Features

### DNS Firewall

The "Matrix" project is a meticulously crafted and entirely self-managed DNS
Firewall utilising Response Policy Zones (RPZ). The primary objective of this
project is to safeguard your privacy by obstructing access to malicious domains
and tracking servers, thereby providing a secure online environment. Given the
escalating instances of online tracking and data breaches, it is imperative to
adopt measures to protect one's privacy online.

### Anti-Porn (Anti-NSFW) List

A notable feature of this project is the anti-porn (anti-NSFW) list, which
restricts access to pornographic and explicit websites. This feature is
particularly beneficial for parents who wish to prevent their children from
encountering inappropriate content online.

## Source List

The `source` directory comprises various sub-folders, each representing distinct
groups for domain submissions. For instance, `google.*` is included in several
groups due to its extensive online presence.

## Categorising

Each sub-folder within `sources` contains a README file that outlines the list
and criteria for adding domains to its `domain.list` or `wildcard.list`.
Detailed explanations for each category are available in
the [Matrix Source Files](source/README.md).

## Submitting

To report problematic websites, please create a new issue for each domain,
providing the URL and a screenshot for evidence.

To report problematic websites, please follow these steps:

- Create a new issue for each problematic website.
- Provide the website's URL and a screenshot as evidence.
- If there is already an issue for the
  website's [eTLD](https://kb.mypdns.org/articles/MTX-A-89)
  or [gTLD](https://kb.mypdns.org/articles/MTX-A-90) domain (like "example.com"
  or "example.org"), add your report to that existing issue.
- If no issue exists for that domain, create a new issue with the
  domains [eTLD](https://kb.mypdns.org/articles/MTX-A-89)
  or [gTLD](https://kb.mypdns.org/articles/MTX-A-90) as the title.

## Combining the Matrix

With [RPZ](https://kb.mypdns.org/articles/MTX/RPZ), we utilise `wildcard.list`
and `domain.list` records, which explains the absence of a
hosts ([RFC:952](https://www.rfc-editor.org/rfc/rfc952)) file in our source
list. To use My Privacy DNS's records Matrix with systems such as Pi-hole or
`/etc/hosts`, combine both the `wildcard.list` and `domain.list`.

## Whitelist

The whitelist is complex and requires meticulous handling. It is crucial to note
that whitelisting is a personal task and should not be undertaken by third
parties.

For instance, Gitlab hosts user-submitted content and may occasionally be
flagged for malicious code. However, blocking it would significantly impact our
workflow, necessitating its inclusion on the whitelist.

## Bulk Commits

Bulk commits are permissible solely if executed by a @developer of the
repository and only when the source is commonly trusted and the number of
domains makes individual issues impractical.

## FAQ

### Broken Site

**Q**: Your lists have broken my website by blocking a third-party domain!

**A**: We have not caused your website to malfunction. The issue stems from your
own miswritten code that compromises privacy by involving third parties.

### Why Not Whitelisting

**Q**: Why don't you whitelist `example.com`?

**A**:

1. It is the responsibility of individual users to create and maintain their own
   whitelist.
2. Whitelisting a malicious domain like domain X because website Y uses it
   misleads our users.
3. Our objective is to provide users with accurate information to enable
   informed decisions.

## Donations

[![ko-fi](https://www.mypdns.org/fileproxy/?name=sp_kofi_mypdns)]([DONATION.md](https://kb.mypdns.org/articles/MTX-A-3/DONATION))
[![liberapay](https://www.mypdns.org/fileproxy/?name=sp_receives_mypdns)](https://liberapay.com/MyPDNS/donate)
[![goal](https://www.mypdns.org/fileproxy/?name=sp_goal_mypdns)](https://liberapay.com/MyPDNS/donate)

We highly appreciate any contributions to support My Privacy DNS, a project
committed to protecting online privacy.
By [donating to My Privacy DNS](https://www.mypdns.org/donate), you are aiding
in the continuation of this valuable service, which remains free of charge to
the public, and supporting the development of additional privacy-friendly
software.

## Sponsors

- Jetbrains: Free licence, might be provided, for members working more than 3
  months on the My Privacy DNS open source project under a non-commercial
  licence.

## Official Mirrors

The following repositories are official mirrors and should be updated by
`push on commit`:

| Project         | Host                                                       | Method (push \| pull) |
|:----------------|:-----------------------------------------------------------|----------------------:|
| Adblocker Rules | `https://git.disroot.org/my-privacy-dns/adblocker-rules`   |                  push |
| Adblocker Rules | `https://gitea.slowb.ro/spirillen/adblocker-rules`         |                  pull |
| Adblocker Rules | `https://github.com/mypdns/adblocker-rules`                |                  push |
| Adblocker Rules | `https://gitlab.com/my-privacy-dns/matrix/adblocker-rules` |                  push |
| =============   | =====================================================      |      ================ |
| Matrix          | `https://gitea.slowb.ro/spirillen/matrix`                  |                  push |
| Matrix          | `https://gitlab.com/my-privacy-dns/matrix/matrix`          |                  push |

## Licensing Information

This project is licensed under two different licences depending on the type of
files:

- **Data Files**: All data files in the `source/` directory are licensed under
  the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Licence (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/).
- **Source Code and Other Files**: All other files in this repository are
  licensed under
  the [GNU Affero General Public Licence version 3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0.html).

For more details, please refer to the respective licence files included in this
repository.

[Bulk-commits]: https://kb.mypdns.org/articles/MTX/Contributing#bulk-commits

[DNS-Server]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=DNS%20Server
[EasyList]: https://github.com/easylist/easylist/

[Gambling]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Gambling
[getadmiral]: https://kb.mypdns.org/issues?q=project:%20Matrix/3023

[IP-Blocking]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=IP%20Blocking

[MalWare]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Malicious%20MalWare

[Phishing]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Phishing

[PiratedDomain]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Pirated%20Domain

[Redirecting]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Redirecting

[Removal]: #faq

[Removals]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=False%20Positive

[RFC952]: https://www.rfc-editor.org/rfc/rfc952

[RPZ]: https://kb.mypdns.org/articles/MTX/RPZ

[//]: # ([Scamming]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Scamming "Issue template to commit Scamming sites")

[//]: # ()

[//]: # ([Spam]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Spam "Issue template to commit Spam records")

[//]: # ()

[//]: # ([Spyware]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Spyware "Issue template to commit Spyware domains")

[//]: # ()

[//]: # ([Tracking]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Tracking "Issue template to commit Tracking records")

[//]: # ()

[//]: # ([TypoSquatting]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Typo%20Squatting "Issue template to commit Typo Squatting")

[//]: # ()

[//]: # ([Whitelist]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Whitelist )
