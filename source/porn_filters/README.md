# Porn Records

[![My Privacy DNS](https://www.mypdns.org/images/logo.png)](https://www.mypdns.org/)

[![Github](https://github.com/mypdns/matrix/raw/master/.assets/icons/github.png)](https://github.com/mypdns/matrix)
[![ko-fi](https://www.mypdns.org/images/githubbutton_sm.svg)](https://ko-fi.com/X8X37FUGU)
[![liberapay](https://www.mypdns.org/fileproxy/?name=sp_receives_mypdns)](https://liberapay.com/MyPDNS/donate)
[![goal](https://www.mypdns.org/fileproxy/?name=sp_goal_mypdns)](https://liberapay.com/MyPDNS/donate)

This is an endeavor to find porn domains and list them in the shortest
possible format it can be done. This means we are not generating any
pre-configured output zone files in this project, we are simply only storing
and verifying the availability of the records.

<!-- TOC -->

* [Porn Records](#porn-records)
    * [Who Can Use This Project](#who-can-use-this-project)
        * [DNS RPZ Firewall](#dns-rpz-firewall)
        * [Host Files](#host-files)
        * [Pi-Hole](#pi-hole)
        * [AdGuard](#adguard)
        * [Ad Blockers](#ad-blockers)
    * [Combining the Source Matrix](#combining-the-source-matrix)
    * [Classifications Definitions](#classifications-definitions)
        * [Porn](#porn)
        * [Strict Porn](#strict-porn)
        * [Educational](#educational)
        * [Artistic and Art](#artistic-and-art)
        * [News and Articles](#news-and-articles)
        * [Not to Include in Blacklist](#not-to-include-in-blacklist)
    * [Underage Material (CSAM)](#underage-material-csam)
    * [DNS Zones](#dns-zones)
        * [Safe Search Enabled](#safe-search-enabled)
    * [How to Contribute](#how-to-contribute)
    * [Support and Comments](#support-and-comments)
        * [Common Support](#common-support)
        * [Blacklist and Whitelist Rules](#blacklist-and-whitelist-rules)
    * [File structure explained](#file-structure-explained)
    * [Reasons for Contributing](#reasons-for-contributing)
    * [Test Results](#test-results)
    * [Conclusion](#conclusion)
    * [Common Names for Pornographic Domain Names](#common-names-for-pornographic-domain-names)
        * [Browser History](#browser-history)
    * [Buzzwords and Keywords](#buzzwords-and-keywords)
    * [Contact](#contact)
<!-- TOC -->

We do, however, serve a full DNS RPZ Firewall zone from [adult.mypdns.cloud](https://kb.mypdns.org/articles/MTX/RPZ-List#adultmypdnscloud) based on the records from this repository.

We will maintain an [RFC:952](https://www.rfc-editor.org/rfc/rfc952.html) (Hosts files) due to numerous requests and the significant lack of support for DNS RPZ, as well as the general ability to block unwanted adult domains with wildcards.

## Who Can Use This Project

### DNS RPZ Firewall

If you are familiar with [DNS](https://kb.mypdns.org/articles/MTX-A-9/DNS) and how an OS handles DNS queries over network protocols, you have likely updated your local network to use a local [DNS resolver](https://kb.mypdns.org/articles/MTX-A-60/DNS-Resolver) that fully supports [Response Policy zones](https://kb.mypdns.org/articles/MTX/rpz/), such as [PowerDNS Recursor](https://kb.mypdns.org/articles/MTX-A-58/DNS-Setup) or [ICS Bind9+](https://www.isc.org/bind/). While Unbound only has partial support for DNS RPZ, excluding you from the benefits of the `wildcard.rpz-nsdname`.

### Host Files

If you are using the outdated method of blocking DNS queries with a [hosts](https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts) file, you will need to combine all the above files into a flat `hosts` file except `README.md`, `rpz-ip`, and `wildcard.rpz-nsdname`. However, this will give you too many records, as not all domains are served over both `www.$domain.tld` and `$domain.tld` equally, though you will be fully covered.

You can see the full matrix for where your hosts' file is located [here](https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts#location-in-the-file-system).

### Pi-Hole

Since Pi-Hole is limited from using wildcard lists for blacklisting, even though it has regex support, it is capped for internal management only. Read more about it in [What lists to use in pi-hole](https://kb.mypdns.org/issue/MPDNS-2/What-lists-to-use-in-pi-hole) by @pallebone.

### AdGuard

These adult filters are supported by the AdGuard project as well as they are for Pi-Hole, thanks to the [Domains-Only Syntax](https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#domains-only-syntax).

### Ad Blockers

This project supports a variety of ad-blockers such as [uBlock Origin](https://ublockorigin.com/), [AdGuard](#adguard), or less effective software such as `adblockplus.org` with their "Acceptable Ads" policy. This means those who pay them to be "accepted" are allowed through the filters. This is not hidden, just not listed on the front page.

The common factor is you can include an external list to those default setups. How this is done depends on the software you have chosen.

## Combining the Source Matrix

**Introduction**: The difference between files inside `source/explicit_content`
and `source/strict_filters` is that the strict folder contains domains that also
host SFW contents, while records found in `adult.mypdns.cloud` are mainly adult
domains.

The description of the file's contents is independent of the folder.

| File                   | Contents / Purpose                                                                                                                                                                                              |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `domains.csv`          | This file is for domains that cannot be blocked with `wildcard.csv`. It lists subdomains solely used for porn hosting. This file is relevant for...                                                             |
| `hosts.txt`            | This list is unrelated to `domains.csv` and contains only supplementary records required by dumb hosts files, such as `lang.$domain.$TLD` or `cdn.$domain.$TLD`.                                                |
| `mobile.txt`           | This list is for mobile-specific domains like `m.example.net`. This list is probably outdated, as responsive web design is now the norm.                                                                        |
| `rpz-ip`               | To block any [NSFW](https://kb.mypdns.org/issues?q=tag:%7BNSFW%20Adult%20Material%7D) by their [IP addresses](https://kb.mypdns.org/articles/MTX-A-10/RPZ-record-types#the-response-ip-address-trigger-rpz-ip). |
| `snuff.csv`            | Snuff Porno. These records will be part of the [adult.mypdns.cloud](https://kb.mypdns.org/articles/MTX/RPZ-List#adultmypdnscloud) RPZ Firewall zone.                                                            |
| `tld.csv`              | This list contains Top Level Domains like `.xxx`. This allows us to block a large number of adult-specific domains.                                                                                             |
| `wildcard.csv`         | This is the core list for domains primarily hosting pornography, suitable for wildcard formats used by proper [DNS resolvers](https://kb.mypdns.org/articles/MTX-A-60/DNS-Resolver).                            |
| `white.csv`            | The locally hosted list for domains that should never be included in any of the above categories or lists.                                                                                                      |
| `wildcard.rpz-nsdname` | This file blacklists DNS servers solely used for serving pornography. It helps minimise the number of entries.                                                                                                  |
| `README.md`            | See [source/porn_filters/README.md](../source/porn_filters/README.md).                                                                                                                                          |

## Classifications Definitions

### Porn

The "NSFW Adult Material" label is used by My Privacy DNS moderators for any domains with pornographic (NSFW) content. This includes explicit nudity or sexual acts for pornographic purposes and dating sites.

### Strict Porn

This list serves two goals: blocking domains that might be considered SFW but serve a significant amount of porn, such as `*.bp.blogspot.com`, and including less NSFW content that would still be considered NSFW explicit content.

Domains that are or can be categorised as [News](https://kb.mypdns.org/articles/MTX-A-49/News), [educational](#educational), or [art](#artistic-and-art) are *not* considered strict porn.

These files may contain domains used to host non-adult related content, potentially causing several [False Positives](https://kb.mypdns.org/articles/MTX-A-82/False-Positive).

Please see the [README.md](https://github.com/mypdns/matrix/blob/master/source/porn_filters/strict_filters/README.md) for the most updated information about the Strict lists project.

### Educational

Domains or sites hosting any nude or explicit content for educational purposes, like explaining `x` or teaching `y`, are not classified in this project.

Any requests to block such content should be redirected to the [Matrix](https://github.com/mypdns/matrix) project.

### Artistic and Art

Content that could be found at an art museum should be considered art.

### News and Articles

News and article-like content that reports accidents based on facts should have wider acceptance for NSFW content as long as it relates to the articles.

### Not to Include in Blacklist

The following are examples of what [My Privacy DNS](https://www.mypdns.org/) projects will not be blocking access to:

- Domains hosting content that is not intended as adult entertainment, such as girls in bikinis at the beach.
- Content deemed acceptable in the western public sphere.

## Underage Material (CSAM)

If you find any underage material online and wish to report it to our project, please mention it at the beginning of the issue with a single `#` at the start of the text and *do not* post any media as proof.

Reporting to other resources is encouraged to help coordinate your reports. Some organisations to consider:

- Red Barnet (Save the Children) at https://redbarnet.dk/anmelddet/
- Arachnid Project at https://projectarachnid.ca/en/
- Your local (uncorrupted) police authority if available in your country or region.

## DNS Zones

If you have updated your system to use a DNS resolver rather than using the `hosts` file, we generate a few zone files for Unbound, dnsmasq, and regular RPZ supported resolvers.

**Note**: For more information on switching to a local DNS resolver, please read this [wiki](https://kb.mypdns.org/articles/MTX-A-60/DNS-Resolver).

### Safe Search Enabled

Additionally, there is a source file that enforces Safe Search in [duckduckgo](https://safe.duckduckgo.com).

For unsafe search portals, we have added `Bing` and `Google` "safe search IPs". These have not been tested as both are privately blocked for [Spyware](https://kb.mypdns.org/articles/MTX-A-44/Spyware) issues.

It can be found [here](https://github.com/mypdns/matrix/tree/master/safesearch).

## How to Contribute

You can use the
following [quick links](https://kb.mypdns.org/articles/MTX-A-1/Contributing "How to contribute to My Privacy DNS")
to open the proper domain report.

## Support and Comments

### Common Support

Please use our [Support board](https://www.mypdns.org/support.html) for any non-blacklist rules questions.

### Blacklist and Whitelist Rules

For any rule-based comments, commits, edits, or contributions, please visit https://github.com/mypdns/matrix and https://kb.mypdns.org/issues?q=project:%20Matrix.

- Commit new rule: https://kb.mypdns.org/newIssue?project=MTX
- Knowledge Base: https://kb.mypdns.org/articles/MTX

This is where you contribute new domains matching any of these subfiles.

## File structure explained

```bash
submit_here
├── source/explicit_content
│   ├── source/explicit_content/domains.csv
│   ├── source/explicit_content/hosts.csv
│   ├── source/explicit_content/mobile.csv
│   ├── source/explicit_content/rpz-ip.csv
│   ├── source/explicit_content/snuff.csv
│   ├── source/explicit_content/tld.csv
│   ├── source/explicit_content/wildcard.csv
│   └── source/explicit_content/wildcard.rpz-nsdname.csv
├── source/strict_filters
│   ├── source/strict_filters/README.md
│   ├── source/strict_filters/strict.domains.csv
│   ├── source/strict_filters/strict.hosts.csv
│   ├── source/strict_filters/strict.rpz-ip.csv
│   ├── source/strict_filters/strict.white.csv
│   ├── source/strict_filters/strict.wildcard.csv
│   └── source/strict_filters/strict.wildcard.rpz-nsdname.csv
└── submit_here/white.csv
```

| File / Path                 | Description - Intended Usage / Coverage                                                                                                                                                                                                    |
|:----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `source/explicit_content/`: |                                                                                                                                                                                                                                            |
| domains.csv                 | This file is used to blacklist subdomains that cannot be covered by using wildcard methods because either the main or other sub-domains do not match a "NSFW::Porn" rule.                                                                  |
| hosts.csv                   | This file should only be used as a support <br/>to [RFC:952][RFC952] based BlackList in combination with a wildcard blacklisted domain. This list is unrelated to the `domain.csv` as it is the ONLY addition for hosts driven blacklists. |
| mobile.csv                  | This list is considered obsolete, as responsive web design has overtaken the initial days of specific web design for mobile devices. There will probably be no further additions.                                                          |
| rpz-ip.csv                  | A list in `.in-addr.arpa.` reverse styled IP Blacklist to be used for DNS RPZ [Response IP Address][IP_Addresses]                                                                                                                          |
| snuff.csv                   | This list is used for blacklisting both "NSFW::Gore" and snuff, even though these are two different things, the list is too small to separate them.                                                                                        |
| tld.csv                     | [TLD] means Top Level Domain like `.org` is a top-level domain. We can, with DNS RPZ, benefit from the wildcard capability to blacklist certain TLDs reserved for the adult entertainment industry such as `.sex` and `.adult`.            |
| white.csv                   | Do you need more time to figure this one out?                                                                                                                                                                                              |
| wildcard.csv                | The wildcard Blacklist is used to blacklist any (second level from the [TLD]) domains for which the contents are pornographic (NSFW) concepts. This means explicit nudity or sexual acts for pornographic entertainment purposes only.     |
| wildcard.rpz-nsdname.csv    | This list contains DNS names of DNS Servers exclusively used for hosting pornography domains.                                                                                                                                              |
|                             |                                                                                                                                                                                                                                            |
| `source/strict_filters/`:   |                                                                                                                                                                                                                                            |
| domains.csv                 | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |
| hosts.csv                   | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |
| rpz-ip.csv                  | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |
| white.csv                   | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |
| wildcard.csv                | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |
| wildcard.rpz-nsdname.csv    | See above, but for [Strict Blacklisting](#strict-porn)                                                                                                                                                                                     |

## Reasons for Contributing

You should [contribute](https://kb.mypdns.org/articles) to this list because it is crucial for those who need to block this type of content.

Let's compare our efforts with Cloudflare's so-called adult filter available at `1.1.1.3` on [Cloudflare DNS for Families](https://cloudflare-dns.com/family/).

From the test file
`https://mypdns.org/clefspeare13/pornhosts/-/blob/master/0.0.0.0/hosts` (No
longer available, as GitHub have blocked the project) which we are going to use
for our test we see the following result and why it matters you are
contributing.

## Test Results

| Status   | Percentage | Numbers |
|:---------|-----------:|--------:|
| ACTIVE   |        96% |    8615 |
| INACTIVE |         3% |     356 |
| INVALID  |         0% |       0 |

## Conclusion

We can conclude that this project identifies 8615 domains that Cloudflare DNS does not recognise.

## Common Names for Pornographic Domain Names

We have begun extracting the most commonly used tags within domain names and published the list [here](https://www.matrix.rocks/). Note that this URL is subject to change later.

### Browser History

Remember to clear your browser history after bypassing these filters!

[![Clear Browser History](https://github.com/mypdns/matrix/blob/master/.assets/browser-history.jpeg?raw=true)](http://joyreactor.com/post/716777 "Clear your browser history")

## Buzzwords and Keywords

Adult Only, DNS Filter, DNS Firewall, Family Filter, Family Shield, FamilyShield, hosts file, hosts-file, Kids Safe, NSFW, parental control, Pi-Hole, PiHole, Porn Block, Porn Blocker, Porn Detection, Porn Filter, Porn Records, Pornhost, Pornographic, Pornography, PyFunceble, Safe Kids

## Contact

Please see [contact information][contact]

[//]: # (The Link section)

[adult.mypdns.cloud]: https://kb.mypdns.org/articles/MTX/RPZ-List#adultmypdnscloud "RPZ zone adult.mypdns.cloud"

[contact]: https://www.mypdns.org/support "Get in touch with My Privacy DNS"
[CONTRIBUTING]: https://kb.mypdns.org/articles/MTX-A-1/Contributing "How to contribute to My Privacy DNS"
[DNS_RPZ]: https://kb.mypdns.org/articles/MTX/rpz/ "DNS RPZ Firewall"
[DNS-hosts]: https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts#location-in-the-file-system "hosts files locations"
[DNS-resolver]: https://kb.mypdns.org/articles/MTX-A-60/DNS-Resolver "DNS recursors and DNS resolver"
[DNS]: https://kb.mypdns.org/articles/MTX-A-9/DNS
[Domains-Only Syntax]: https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#domains-only-syntax
[FalsePositive]: https://kb.mypdns.org/articles/MTX-A-82/False-Positive "What is: False Positive"
[ICS-Bind9]: https://www.isc.org/bind/
[IP_Addresses]: https://kb.mypdns.org/articles/MTX-A-10/RPZ-record-types#the-response-ip-address-trigger-rpz-ip "The "Response IP Address" Trigger (.rpz-ip)"
[matrix]: https://github.com/mypdns/matrix "My Privacy DNS is aiming to be the most intelligent DNS Firewall throughout using the modern DNS RPZ approach"
[mypdns]: https://www.mypdns.org/ "My Privacy DNS - Let no one spy on you online"
[news]: https://kb.mypdns.org/articles/MTX-A-49/News
[NSFW]: https://kb.mypdns.org/issues?q=tag:%7BNSFW%20Adult%20Material%7D "Not Safe For Religious people"
[pi-hole_combo]: https://kb.mypdns.org/issue/MPDNS-2/What-lists-to-use-in-pi-hole "What lists to use in pi-hole"
[PowerDNS-Recursor]: https://kb.mypdns.org/articles/MTX-A-58/DNS-Setup "PowerDNS Recursor"
[PR]: https://github.com/mypdns/matrix/tree/master/source/porn_filters
[rfc_1123]: https://www.rfc-editor.org/rfc/rfc1123 "Requirements for Internet Hosts"
[RFC952]: https://www.rfc-editor.org/rfc/rfc952.html "DOD INTERNET HOST TABLE
SPECIFICATION"
[SpyWare]: https://kb.mypdns.org/articles/MTX-A-44/Spyware "What is SpyWare"
[strict_readme.md]: https://github.com/mypdns/matrix/blob/master/source/porn_filters/strict_filters/README.md "The strict anti adult files"
[support]: https://www.mypdns.org/support.html "Support Forum for all non blacklisting questions"
[TLD]: https://kb.mypdns.org/articles/MTX-A-70/TLD-Top-Level-Domain "What is a Top level domain"
[uBlockOrigin]: https://ublockorigin.com/ "uBlock Origin is a free and open-source, cross-platform browser extension for content-filtering, including ad-blocking."
[wiki_DNS_host]: https://kb.mypdns.org/articles/MTX-A-62/DNS-Hosts "Hosts files"
[wiki_rpz-nsdname]: https://kb.mypdns.org/articles/MTX-A-10/RPZ-record-types#the-nsdname-trigger-rpz-nsdname "DNS RPZ rpz-nsdname record types"
