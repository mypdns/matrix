I report this [Tracking] related domain(s) to be added into the [MyPrivacy DNS RPZ Firewall][mpdrf]

```
(input your domain name here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Tracking
*.domain_name_here   CNAME . ; Tracking
```

### Additional requirements for

#### [hosts] and [Pi-hole]

```css
null
```

```css
+ www
- www
www.
```

#### Adblocker
<details><summary>Click to expand</summary>

```css
N/A
```

</details>

## Screenshots
This text appears on all Admirals owned domains

![Screeshot](https://mypdns.org/my-privacy-dns/matrix/uploads/d9aae9b533ce6a4620dafa5da4533e58/image.png)

## Comments
<!-- Comments such as specific URL to view contents -->

This domain is used by [`getadmiral.com`][getadmiral] to collect your surfing habits and the are using a variety of scripts to generate a personal identification of you and your devices. Follow [getadmiral][getadmiral] for updates.

You can always find the latest list of Admiral's Active domains in milestone %"getadmiral.com"

## External sources
<!-- if you took this domain from other board -->
- ``

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) document?
- [X] Have you checked to ensure there aren't other open [Merge Requests (MR)][MR] or [issue] for the same update/change?
- [X] Have you added an explanation of what your submission do and why you'd like us to include them??
- [X] Added [screenshot] for prove of [False Negative][FN]

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server
- [X] Added to Source file

[Tracking]: https://mypdns.org/mypdns/support/-/wikis/Categories/Trackware
[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[getadmiral]: https://mypdns.org/my-privacy-dns/matrix/-/issues/3023
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"

/milestone %"getadmiral.com"

/label ~Tracking

/weight 10

/publish

/severity critical

/health_status at_risk
