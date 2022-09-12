I report this ~"NSFW::Porn" related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(input your domain name here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Adult
*.domain_name_here   CNAME . ; Adult
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

<details><summary><b><i>NSFW</i></b> Screenshot</summary>

(Upload your screenshot here)

</details>

## Comments
<!-- Comments such as specific URL to view contents -->

## My Privacy DNS issues
- `` #

## External sources
<!-- if you took this domain from other board -->
- ``

### All Submissions:
- [ ] Did you follow the guidelines in the [Contributing](CONTRIBUTING.md) document?
- [ ] Have you added an explanation of what your submission do and why you'd like us to include them??
- [ ] Have you checked to ensure there aren't other open [Merge Requests (MR)][MR] or [issue] for the same update/change?
- [ ] Added [screenshot] for prove of [False Negative][FN]

### Todo
- [X] Added to Source file?
- [X] Added to the RPZ zone

#### Logger output

<details><summary>3rd party Domains</summary>

```python
N/A
```

</details>

[adultmypdnscloud]: https://mypdns.org/mypdns/support/-/wikis/RPZ-List#adultmypdnscloud "Rpz Zone for blocking Porn"
[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/-/tree/master/source/porn_filters "My Privacy DNS RPZ Parental Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"

/label ~"NSFW::Porn"

/weight 0

/health_status on_track

/severity low

/publish
