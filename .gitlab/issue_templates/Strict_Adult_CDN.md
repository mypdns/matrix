<!-- Find tips in the bottom -->

I report this ~"CDN::NSFW-Strict" related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(please input basedomain here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Adult
*.domain_name_here   CNAME . ; Adult
```

CDN See [Linked issues](#linked-issues) for details

### Additional requirements for

#### [hosts] and [Pi-hole]
<details><summary>Click to expand</summary>

```css
NULL
```

```css
+ www
- www
www.
```

</details>

#### Adblocker
<details><summary>Click to expand</summary>

```css
N/A
```
</details>

## My Privacy DNS issues

## Comments
<!-- comments like a specific url to see contents -->

## My Privacy DNS issues
- `` #

## External sources
<!-- If you found this domain on another issueboard -->

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) documentation?
- [ ] Added [screenshot] for prove of [False Negative][FN]

### Todo
- [ ] Added to Source file?
- [ ] Added to the RPZ zone [strict.adult.mypdns.cloud] (\@spirillen)

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/-/tree/master/source/porn_filters "My Privacy DNS RPZ Parental Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"
[strict.adult.mypdns.cloud]: https://mypdns.org/mypdns/support/-/wikis/RPZ-List#strictadultmypdnscloud

/health_status on_track

/label ~"CDN::NSFW-Strict"

/publish

/severity low

/weight 1
