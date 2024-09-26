[![ko-fi](https://www.mypdns.org/images/githubbutton_sm.svg)](https://ko-fi.com/X8X37FUGU)

# Porn Records
This is an endeavour to find porn domains and list them in the shortest
possible format it can be done. This means we are not generating any
pre-configured output zone files in this project, we are simply only
storing, and verifying the availability of the records.

- [Porn Records](#porn-records)
  - [Who can use this project](#who-can-use-this-project)
    - [DNS RPZ Firewall](#dns-rpz-firewall)
    - [Hosts files](#hosts-files)
    - [Pi-Hole](#pi-hole)
    - [AdGuard](#adguard)
    - [Ad blockers](#ad-blockers)
  - [Combining the Source Matrix](#combining-the-source-matrix)
  - [Classifications Definitions](#classifications-definitions)
    - [Porn](#porn)
    - [Strict Porn](#strict-porn)
    - [Educational](#educational)
    - [Artistic and Art](#artistic-and-art)
    - [News and Articles](#news-and-articles)
    - [Not to include in black blocklist](#not-to-include-in-black-blocklist)
  - [Underage material (CSAM)](#underage-material-csam)
  - [DNS zones](#dns-zones)
    - [Safe search enabled](#safe-search-enabled)
  - [How to Contribute](#how-to-contribute)
  - [Support and comments](#support-and-comments)
    - [Common support](#common-support)
    - [Black- and whitelist Rules](#black-and-whitelist-rules)
  - [File structure explained](#file-structure-explained)
  - [Why contributing](#why-contributing)
  - [Test result](#test-result)
  - [Conclusion](#conclusion)
  - [The most common name for porn domain-name](#the-most-common-name-for-porn-domain-name)
    - [Browser history](#browser-history)
  - [Buzz words and keyword](#buzz-words-and-keyword)
  - [Contact](#contact)

We do however serve a full DNS RPZ Firewall zone from
[adult.mypdns.cloud][adult.mypdns.cloud] purely based on the records
from this repository.

This said we will maintain a [RFC:952][rfc_952] (Hosts files) do to
numerous requests, as unfortunately a significant lack of support
for DNS RPZ and just in general, the capability to block unwanted adult
porno domains with wildcards.

## Who can use this project

### DNS RPZ Firewall

If you, like the rest of the world, who knows just a bit about
[DNS][DNS] and how an OS (Operating System) is handling DNS queries over
the network protocols, you have of course updated your local network to
use a local [DNS resolver][DNS-resolver] that have the full support of the
[Response Policy zones][DNS_RPZ], such as the
[PowerDNS Recursor][PowerDNS-Recursor] or [ICS Bind9+][ICS-Bind9],
while unbound only have partial support of DNS RPZ, you will be excluded
from the benefits of the `wildcard.rpz-nsdname`.

### Hosts files

If you are stocked on the very weird and extremely outdated way of
blocking DNS queries with a [hosts][wiki_DNS_host]
file. You'll need to combine all the above files into a flat `hosts`
file except `README.md`, `rpz-ip` and `wildcard.rpz-nsdname`,
however, this _WILL_ give you too many records,
as not necessary all domains are served over both `www.$domain.tld` and
`$domain.tld` equally, you will however be covered in full.

You can see the full matrix for where your hosts' file is located
[here][DNS-hosts].

### Pi-Hole

Since Pi-hole is crippled from using wildcard lists for blacklisting
through they have regex support, then this is capped to be used for
internal management only. Read more about it in
[What lists to use in pi-hole][pi-hole_combo] by @pallebone

### AdGuard

These Adult filters are supported by the AdGuard project just as
well as there are for Pi-Hole thanks to the
[Domains-Only Syntax][Domains-Only Syntax]

### Ad blockers

This project should be supporting a variety of ad-blockers such as
[uBlock Origin][uBlockOrigin], [AdGuard](#adguard) or less effective
software such as `adblockplus.org` with their "Acceptable Ads", which
means who pays them to be "accepted" - this is not hidden information,
it is just not listed on the front page.

The common thing is you can include an external list to those default setups.
How this is done depends on the Software you have chosen.

## Combining the Source Matrix

**Intro**: The difference between files inside `source/explicit_content` and
`source/strict_filters` is that the strict folder contains domains that
otherwise *also* hosts SFW contents, while records found in the
`adult.mypdns.cloud` is mainly adult domains.<br>The description of the file's
contents is equal independent of the folder

| File                   | Contents / Purpose                                                                                                                                                                                                                                                                                                                                              | Used by:<br>[DNS RPZ](#dns-rpz-firewall) | Used by:<br>[Pi-Hole](#pi-hole) | Used by:<br>[Hosts files](#hosts-files) | Used by:<br>[AdGuard](#adguard) | Used by:<br />[Ad blockers](#ad-blockers) |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------: | :-----------------------------: | :-------------------------------------: | :-----------------------------: | :---------------------------------------: |
| `domains.list`         | This file is only for domains that can not be blocked with the `wildcard.list`. This is a list of subdomains, which solely is used for porn hosting, This file is relevant in IE. open blogs domains as `*.blogspot.TLD` or `disqus.com` (Adult Only).                                                                                                          |            :heavy_check_mark:            |       :heavy_check_mark:        |           :heavy_check_mark:            |       :heavy_check_mark:        |            :heavy_check_mark:             |
| `hosts.txt`            | This list is unrelated to `domains.list` and contains only supplementary records required by dumb hosts files, such as `lang.$domain.$TLD` or `cdn.$domain.$TLD` as hosts files requires exact match to function [rfc:952][rfc_952] and [rfc:1123][rfc_1123]. You should also take a look at this [wiki page][wiki_DNS_host] to read more about the hosts file. |         :heavy_multiplication_x:         |       :heavy_check_mark:        |           :heavy_check_mark:            |       :heavy_check_mark:        |            :heavy_check_mark:             |
| `mobile.txt`           | Same as `hosts.txt` but only mobile-specific domains like `m.example.net` as this is otherwise covered by the `wildcard.list`. This list is probably as good as dead, thanks to the responsive design nowadays. This list is swallowed by the ordinary hosts or subsidiaries of the domain.list                                                                 |         :heavy_multiplication_x:         |       :heavy_check_mark:        |           :heavy_check_mark:            |       :heavy_check_mark:        |         :heavy_multiplication_x:          |
| `rpz-ip`               | To block any [#NSFW][NSFW] by their [IP addresses][IP_Addresses], yes, yet another cool DNS RPZ feature, that hosts files don't have.                                                                                                                                                                                                                           |            :heavy_check_mark:            |    :heavy_multiplication_x:     |        :heavy_multiplication_x:         |    :heavy_multiplication_x:     |         :heavy_multiplication_x:          |
| `snuff.list`           | Snuff Porno (No wildcard this far as the zone is way too small for that) These records will be part of the [adult.mypdns.cloud][adult.mypdns.cloud] RPZ Firewall zone                                                                                                                                                                                           |            :heavy_check_mark:            |       :heavy_check_mark:        |           :heavy_check_mark:            |       :heavy_check_mark:        |         :heavy_multiplication_x:          |
| `tld.list`             | This list contains Top Level Domains like `.xxx` which with wildcard allow us to make a huge impact on an adult-specific domain. A very short list, was made to avoid FP while testing with @Pyfunceble.                                                                                                                                                        |            :heavy_check_mark:            |    :heavy_multiplication_x:     |        :heavy_multiplication_x:         |    :heavy_multiplication_x:     |            :heavy_check_mark:             |
| `wildcard.list`        | This is the core domains for the rest of the "sub" files for which domains primarily hosting Porno and therefore can be in wildcard formats used by proper [DNS recursor's][DNS-resolver] that in full supports [DNS RPZ][DNS_RPZ]                                                                                                                              |            :heavy_check_mark:            |       :heavy_check_mark:        |           :heavy_check_mark:            |       :heavy_check_mark:        |            :heavy_check_mark:             |
| `white.list`           | The locally hosted list for domains that never should be put into any of the above categories or lists                                                                                                                                                                                                                                                          |            :heavy_check_mark:            |    :heavy_multiplication_x:     |        :heavy_multiplication_x:         |    :heavy_multiplication_x:     |         :heavy_multiplication_x:          |
| `wildcard.rpz-nsdname` | This file is to blacklist any DNS servers, that are solely used for serving porn. By using a zone like this, we can minimize the entire number of entries quite a bit, as ex. all `.xxx` domains are served from the same root server. Read more about how the rpz-nsdname records on this [wiki page][wiki_rpz-nsdname]                                        |            :heavy_check_mark:            |    :heavy_multiplication_x:     |        :heavy_multiplication_x:         |    :heavy_multiplication_x:     |            :heavy_check_mark:             |
| `README.md`            | See [source/parental_control/README.md](../source/parental_control/README.md)                                                                                                                                                                                                                                                                                   |                                          |                                 |                                         |                                 |


## Classifications Definitions

### Porn

The "NSFW Adult Material" label, is used by My Privacy DNS moderators for any
domains for which the contents are pornographic (NSFW) concepts. This means
explicit nudity or sexual acts for pornographic purposes and sited such as
dating sites.

### Strict Porn
This list serves two goals, blocking domains that ordinary might be considered
as SFW but which do serve a tremendous amount of porn, such as
`*.bp.blogspot.com`, the other purpose is to also include the less NSFW
Classifiable content which as such would be considered as NSFW explicit content.

What is *NOT* strict- or porn by My Privacy DNS is domains that are or
can be categorized as [News][news], [educational](#educational) or
[art](#artistic-and-art)

These files will contain domains which primary is used to host non-adult
related contents and for that, you might feel like experiencing several
[False Positive][FalsePositive]'s while they are in their right blacklists.

In addition, please see the [README.md][strict_readme.md] to get the most
updated information about the Strict lists project.


### Educational
Domains or sites that host any nude or explicit content used for an
educational purpose, like telling about `x` and/or teaching about `y`
is to not be classified in this project.

Any requests to block any of that kind of content should probably be
redirected to the [Matrix][matrix] project instead.


### Artistic and Art
What should be considered art is content that could be found at
a museum for arts.


### News and Articles
News and Articles (-like) content that is an article or reporting an
accident, based on facts should have a wider range of acceptance for
usage of NSFW content as long it relates to the article(s).


### Not to include in black blocklist
The following are examples of what [My Privacy DNS](mypdns)
projects will not be blocking access. Domains that host content for
which it isn't hard to find in the western public sphere and for which
the material is NOT intended as Adult entertainment; such as girls in
bikinis, going to the beach on a superheated summer day and there are plenty
of topless humans there as well.

This kind of new religious and Amish/Jewish/Mormons/Muslim perception of
acceptable behaviours, endangerment's or social control for which should
be "parental" blacklisted is falling outside of this project.


## Underage material (CSAM)
If you find any underage material online, and you're thinking of committing
it to our project, we will be honoured and respectfully ask you to mention
this in the very beginning of the issue with a big letter, a single `#` at
the beginning of the text and please do *NOT* post any media as proof.

If you choose to report to all resources please do inform them about
the issue here at [mypdns.org][mypdns] to help keep track on the
coordination of your reports.

Second, you should report your found to any of the following projects.

- Red Barnet (save the children) online service at https://redbarnet.dk/anmelddet/
- Arachnid Project at https://projectarachnid.ca/en/
- Your local (uncorrupted) police authority if such a thing is present in
  your country or region.


## DNS zones
If you are so lucky that you have updated your system to use a DNS
resolver rather than abusing your disk-IO with the `hosts` file, we also
generate a few zone files for Unbound, dnsmasq and regular RPZ supported
resolvers.

**Note**: If you will read more about why you should switch to a local
DNS resolver, please read this [wiki][DNS-resolver]


### Safe search enabled
Additionally, there is a source file that will enforce Safe Search in
the safer and more privacy-aware [duckduckgo](https://safe.duckduckgo.com).

For unsafe search portals, we have added `Bing` and `Google` "safe search
IP's".

However, it has not been tested yet as both are blocked privately for
[Spyware's][SpyWare] issues with both domains in question. It can be found
[here](https://github.com/mypdns/matrix/tree/master/safesearch)


## How to Contribute
You can use the following quick links to open the proper domain report.
See also: [Reporting tool][#reporting-tool]

## Support and comments

### Common support
Please do use our [Support board][support] for any non-Blacklist rules
questions.


### Black- and whitelist Rules

For any rule-based comments, commits, edits or contributions, we only support
that at https://github.com/mypdns/matrix and
https://kb.mypdns.org/issues?q=project:%20Matrix

* Commit new rule: https://kb.mypdns.org/newIssue?project=MTX
* Knowledge Base: https://kb.mypdns.org/articles/MTX

This is where you contribute with new domains matching any of these
subfiles.


## File structure explained

```bash
submit_here
├── source/explicit_content
│   ├── source/explicit_content/domains.list
│   ├── source/explicit_content/hosts.list
│   ├── source/explicit_content/mobile.list
│   ├── source/explicit_content/rpz-ip
│   ├── source/explicit_content/snuff.list
│   ├── source/explicit_content/tld.list
│   ├── source/explicit_content/wildcard.list
│   └── source/explicit_content/wildcard.rpz-nsdname
├── source/strict_filters
│   ├── source/strict_filters/README.md
│   ├── source/strict_filters/strict.domains.list
│   ├── source/strict_filters/strict.hosts.list
│   ├── source/strict_filters/strict.rpz-ip
│   ├── source/strict_filters/strict.white.list
│   ├── source/strict_filters/strict.wildcard.list
│   └── source/strict_filters/strict.wildcard.rpz-nsdname
└── submit_here/white.list
```

| File / path                 | Description - Attended Usage / Covering                                                                                                                                                                                                              |
| :-------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `source/explicit_content/`: |                                                                                                                                                                                                                                                      |
| domains.list                | This file is used to blacklist subdomain, which can't be covered by using a wildcard methods because either the main- or other sub-domains do not match a ~"NSFW::Porn" rule                                                                         |
| hosts.list                  | This file should only be used as a support to [RFC:952][rfc_952] based BlackList in combination with a wildcard blacklisted domain. This list has nothing to do with the `domain.list` as this is the *ONLY* addition for hosts driven blacklists    |
| mobile.list                 | This list is considered dying, as the time where responsive web design has taken over the initial days with specific web design for mobile devices. There will (probably) not be added further to this lists.                                        |
| rpz-ip                      | A lists is `.in-addr.arpa.` reverse styled IP Blacklist to be used for DNS RPZ [Response IP Address][IP_Addresses]                                                                                                                                   |
| snuff.list                  | This list is used for blacklisting **both** ~"NSFW::Gore" and ~snuff, even these these are very two different things, the list is just to small, to separate it                                                                                      |
| tld.list                    | [TLD][TLD] means Top Level Domain like `.org` is a top-level domain, we can with DNS RPZ benefit from the wildcard capability be able to blacklist a few TLD's as they are reserved the adult entertainment industry such as `.sex` and `.adult`     |
| white.list                  | :thinking: :thought_balloon: :coffee: Do you need more time to figure this one out?                                                                                                                                                                  |
| wildcard.list               | The wildcard Blacklist is the list used to blacklist any (second level from the [TLD][TLD]) domains for which the contents are pornographic (NSFW) concepts. This means explicit nudity or sexual acts for pornographic entertainment purpose *only* |
| wildcard.rpz-nsdname        | This list contains DNS names of DNS Servers which only used for hosting Porno domains.                                                                                                                                                               |
|                             |                                                                                                                                                                                                                                                      |
| `source/strict_filters/`:   |                                                                                                                                                                                                                                                      |
| domains.list                | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |
| hosts.list                  | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |
| rpz-ip                      | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |
| white.list                  | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |
| wildcard.list               | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |
| wildcard.rpz-nsdname        | See sibling above :arrow_heading_up: But for [Strict Blacklisting](#strict-porn)                                                                                                                                                                     |


## Why contributing
You should [contribute][CONTRIBUTING] to this list because it does matter
for those who have to block this kind of content.

Let's compare our work against Cloudflare's <https://cloudflare-dns.com/family/>
so-called adult filter running on `1.1.1.3`

From the test file
<https://mypdns.org/clefspeare13/pornhosts/-/blob/master/0.0.0.0/hosts>
which we are going to use for our test we see the following result and
why it matters you are contributing.

## Test result

| Status   | Percentage | Numbers |
| :------- | ---------: | ------: |
| ACTIVE   |        96% |    8615 |
| INACTIVE |         3% |     356 |
| INVALID  |         0% |       0 |

## Conclusion
We can hereby conclude this project knows 8615 domains, which
Cloudflare-DNS does not know about

## The most common name for porn domain-name
We have started to extract the most commonly used tags within the domain names
and published the list here https://www.matrix.rocks/

not the URL is target for changing later

### Browser history
Don't forget to clear your browser history when you have bypassed these
filter!!!

[![browser history](https://github.com/mypdns/matrix/blob/master/.assets/browser-history.jpeg?raw=true)](http://joyreactor.com/post/716777 "clear your browser history")


## Buzz words and keyword
Adult Only, DNS Filter, DNS Firewall, Family Filter, Family Shield,
FamilyShield, hosts file, hosts-file, Kids Safe, NSFW, parental control,
Pi-Hole, PiHole, Porn Block, Porn Blocker, Porn Detection, Porn Filter,
Porn Records, Pornhost, Pornographic, Pornography, PyFunceble, Safe Kids


## Contact
Please see [contact information][contact]

[//]: # (The Link section)
<!-- The Link section -->

[adult.mypdns.cloud]: https://kb.mypdns.org/articles/MTX/RPZ-List#adultmypdnscloud "RPZ zone adult.mypdns.cloud"
[contact]: https://www.mypdns.org/support.html "Get in touch with My Privacy DNS"
[CONTRIBUTING]: https://kb.mypdns.org/articles/MTX-A-1/Contributing "How to contribute to My Privacy DNS"
[DNS_RPZ]: https://kb.mypdns.org/articles/MTX/rpz/ "DNS RPZ Firewall"
[DNS-hosts]: https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts#location-in-the-file-system "hosts files locations"
[DNS-resolver]: https://kb.mypdns.org/articles/MTX-A-60/DNS-Resolver "DNS recursors and DNS resolver"
[DNS]: https://kb.mypdns.org/articles/MTX-A-9/DNS ""
[Domains-Only Syntax]: https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#domains-only-syntax
[FalsePositive]: https://kb.mypdns.org/articles/MTX-A-82/False-Positive "What is: False Positive"
[ICS-Bind9]: https://www.isc.org/bind/
[IP_Addresses]: https://kb.mypdns.org/articles/MTX-A-10/RPZ-record-types#the-response-ip-address-trigger-rpz-ip "The "Response IP Address" Trigger (.rpz-ip)"
[matrix]: https://github.com/mypdns/matrix "My Privacy DNS is aiming to be the most intelligent DNS Firewall throughout using the modern DNS RPZ approach"
[mypdns]: https://www.mypdns.org/
[news]: https://kb.mypdns.org/articles/MTX-A-49/News
[NSFW]: https://kb.mypdns.org/issues?q=tag:%7BNSFW%20Adult%20Material%7D "Not Safe For Religious people"
[pi-hole_combo]: https://kb.mypdns.org/issue/MPDNS-2/What-lists-to-use-in-pi-hole "What lists to use in pi-hole"
[PowerDNS-Recursor]: https://kb.mypdns.org/articles/MTX-A-58/DNS-Setup "PowerDNS Recursor"
[PR]: https://github.com/mypdns/matrix/tree/master/source/porn_filters
[rfc_1123]: https://www.rfc-editor.org/rfc/rfc1123 "Requirements for Internet Hosts"
[rfc_952]: https://www.rfc-editor.org/rfc/rfc952.html "DOD INTERNET HOST TABLE SPECIFICATION"
[SpyWare]: https://kb.mypdns.org/articles/MTX-A-44/Spyware "What is SpyWare"
[strict_readme.md]: https://github.com/mypdns/matrix/blob/master/source/porn_filters/strict_filters/README.md "The strict anti adult files"
[support]: https://www.mypdns.org/support.html "Support Forum for all non blacklisting questions"
[TLD]: https://kb.mypdns.org/articles/MTX-A-70/TLD-Top-Level-Domain "What is a Top level domain"
[uBlockOrigin]: https://ublockorigin.com/ "uBlock Origin is a free and open-source, cross-platform browser extension for content-filtering, including ad-blocking."
[wiki_DNS_host]: https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts "Hosts files "
[wiki_rpz-nsdname]: https://kb.mypdns.org/articles/MTX-A-10/RPZ-record-types#the-nsdname-trigger-rpz-nsdname "DNS RPZ rpz-nsdname record types"
