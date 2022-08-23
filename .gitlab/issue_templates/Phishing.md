I report this [Phishing] related domain(s) to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(please input basedomain here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain   CNAME . ; Phishing, Typo Squatting
*.domain   CNAME . ; Phishing, Typo Squatting
```

## Impersonated - Typo Squatting domain
```css
Required or issue is marked invalid.
```

### Additional requirements for

#### [hosts] and [Pi-hole]
<details><summary>Click to expand</summary>

```css
NULL
```

</details>

```css
+ www
- www
www.
```

#### uBlock Origin adblocker
<details><summary>Click to expand</summary>

```css
N/A
```

</details>


## Screenshots

<details><summary>Click to expand</summary>



</details>

## Comments
<!-- comments like a specific url to see contents -->

## My Privacy DNS issues
- #

## External sources
<!-- If you found this domain on another issueboard -->
- ``


### All Submissions:
- [ ] Did you follow the guidelines in the [Contributing](CONTRIBUTING.md)
	  document?
- [ ] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [ ] Have you checked to ensure there aren't other open
      [Merge Requests (MR)][MR] or [issue] for the same update/change?
- [ ] Added [screenshot] for prove of [False Negative][FN]


### Testing phase
- [ ] Checked the internet for verification?
- [ ] Successfully tested changes locally?

### Todo
- [X] RPZ Server (Team \@Spirillen)
- [X] Added to Source file

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"
[Phishing]: https://mypdns.org/mypdns/support/-/wikis/Categories/Phishing

/label ~Phishing ~Typo_Squatting

/weight 8

/publish

/severity high
