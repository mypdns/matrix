# The Matrix (Formal Version)

[![My Privacy DNS](https://www.mypdns.org/images/logo.png)](https://www.mypdns.org/)

The "Matrix" project by [My Privacy DNS](https://www.mypdns.org/) is a
meticulously crafted and entirely self-managed DNS Firewall utilizing Response
Policy Zones (RPZ). The primary objective of this project is to safeguard your
privacy by obstructing access to malicious domains and tracking servers, thereby
providing a secure online environment. Given the escalating instances of online
tracking and data breaches, it is imperative to adopt measures to protect one's
privacy online.

A notable feature of this project is the anti-porn (anti-NSFW) list, which
restricts access to pornographic and explicit websites. This feature is
particularly beneficial for parents who wish to prevent their children from
encountering inappropriate content online.

## Donations

[![ko-fi](https://www.mypdns.org/fileproxy/?name=sp_kofi_mypdns)]([DONATION.md](https://kb.mypdns.org/articles/MTX-A-3/DONATION))
[![liberapay](https://www.mypdns.org/fileproxy/?name=sp_receives_mypdns)](https://liberapay.com/MyPDNS/donate)
[![goal](https://www.mypdns.org/fileproxy/?name=sp_goal_mypdns)](https://liberapay.com/MyPDNS/donate)

We highly appreciate any contributions to support My Privacy DNS, a project
committed to protecting online privacy.
By [donating to My Privacy DNS](https://kb.mypdns.org/articles/MTX-A-3/DONATION),
you are aiding in the continuation of this valuable service, which remains free
of charge to the public, and supporting the development of additional
privacy-friendly software.

## Source list

The `source` directory comprises various sub-folders, each representing distinct
groups for domain submissions. For instance, `google.*` is included in several
groups due to its extensive online presence.

## Categorizing

Each sub-folder within `sources` contains a README file that outlines the list
and criteria for adding domains to its `domain.list` or `wildcard.list`.
Detailed explanations for each category are available
in [Matrix Source Files](source/README.md).

## Submitting

To report problematic websites, please create a new issue for each domain,
providing the URL and a screenshot for evidence.

## Combining the Matrix

For Adult filtering, please refer to the [README](source/README.md)

With [RPZ][RPZ], we utilize `wildcard.list` and `domain.list` records, which
explains the absence of a hosts ([RFC:952][RFC952]) file in our source list. To
use My Privacy DNS's records Matrix with systems such as Pi-hole or
`/etc/hosts`, combine both the `wildcard.list` and `domain.list`.

## Whitelist

The whitelist is complex and requires meticulous handling. It is crucial to note
that whitelisting is a personal task and should not be undertaken by third
parties.

For instance, Gitlab hosts user-submitted content and may occasionally be
flagged for malicious code. However, blocking it would significantly impact our
workflow, necessitating its inclusion on the whitelist.

## Bulk commits

Bulk commits are permissible solely if executed by a @developer of the
repository and only when the source is commonly trusted and the number of
domains makes individual issues impractical.

## FAQ

### Broken site

**Q**: Your lists have broken my website by blocking a third-party domain!

**A**: We have not caused your website to malfunction. The issue stems from your
own miswritten code that compromises privacy by involving third parties.

### Why not Whitelisting

**Q**: Why don't you whitelist `example.com`?

**A**:

1. It is the responsibility of individual users to create and maintain their own
   whitelist.
2. Whitelisting a malicious domain like domain X because website Y uses it
   misleads our users.
3. Our objective is to provide users with accurate information to enable
   informed decisions.

## Sponsors

- Jetbrains: Free license, might be provided, for members working more than 3
  months on the My Privacy DNS open source project under a non-commercial
  license.

## Official mirrors

The following repositories are official mirrors and should be updated by
`push on commit`:

| Project         | Host                                                       | Method (push \| pull) |
|:----------------|:-----------------------------------------------------------|----------------------:|
| Adblocker Rules | `https://git.disroot.org/my-privacy-dns/adblocker-rules`   |                  push |
| Adblocker Rules | `https://git.kescher.at/my-privacy-dns/adblocker-rules`    |                  pull |
| Adblocker Rules | `https://gitea.slowb.ro/spirillen/adblocker-rules`         |                  pull |
| Adblocker Rules | `https://github.com/mypdns/adblocker-rules`                |                  push |
| Adblocker Rules | `https://gitlab.com/my-privacy-dns/matrix/adblocker-rules` |                  push |
| Adblocker Rules | `https://notabug.org/my-privacy-dns/adblocker-rules`       |                  pull |
| ============    | =====================================================      |      ================ |
| Matrix          | `https://git.disroot.org/my-privacy-dns/matrix`            |                  push |
| Matrix          | `https://gitea.slowb.ro/spirillen/matrix`                  |                  push |
| Matrix          | `https://github.com/mypdns/matrix`                         |                  push |
| Matrix          | `https://gitlab.com/my-privacy-dns/matrix/matrix`          |                  push |
| Matrix          | `https://notabug.org/my-privacy-dns/matrix`                |                  pull |

## Licensing Information

This project is licensed under two different licenses depending on the type of
files:

- **Data Files**: All data files in the `source/` directory are licensed under
  the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/).
- **Source Code and Other Files**: All other files in this repository are
  licensed under
  the [GNU Affero General Public License version 3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0.html).

For more details, please refer to the respective license files included in this
repository.

[//]: # ([AdWare]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=AdWare "Issue template to commit adserver domains")

[Bulk-commits]: https://kb.mypdns.org/articles/MTX/Contributing#bulk-commits

[//]: # ([CryptoMiners]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=CryptoMiner "Issue template to commit Crypto miners")

[DNS-Server]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=DNS%20Server "Issue template to commit For blacklisting at the DNS level"

[EasyList]: https://github.com/easylist/easylist/

[Gambling]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Gambling "Issue template to commit Gambling site"

[getadmiral]: https://kb.mypdns.org/issues?q=project:%20Matrix/3023

[IP-Blocking]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=IP%20Blocking "Issue template to commit Blocking by IP addresses"

[MalWare]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Malicious%20MalWare "Issue template to commit Malicious and or Malware"

[Phishing]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Phishing "Issue template to commit Phishing"

[PiratedDomain]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Pirated%20Domain "Issue template to commit Outdated domain, pirated and hijacked by domains Jackal's"

[Redirecting]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=Redirecting "Issue template to commit URL shortening and other redirecting only domain"

[Removal]: #faq "Read the F.A.Q. *BEFORE* you proceed!"

[Removals]: https://kb.mypdns.org/issues?q=project:%20Matrix/new?issuable_template=False%20Positive "False Positive or removal of domains"

[RFC952]: https://www.rfc-editor.org/rfc/rfc952 "This RFC is the official specification of the Hostname Server Protocol."

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

[RPZ]: https://kb.mypdns.org/articles/MTX/RPZ "Response Policy Zone"
