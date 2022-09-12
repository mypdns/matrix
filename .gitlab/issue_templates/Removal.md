## Summary
<!--
Note: If you're a website owner that has been specifically targeted,
fix the site before reporting. Remove all revolving ad servers, popup ads,
adblock countering etc. Only then will this request be reviewed.

Screenshot is recommanded within the <details> pane. Leave a blank line before
and after the image link.

Summarize the reason encountered precisely, and keep any domains and/or
url's in back ticks `(`)`, we are not a linking service (TGP) -->

This domain Should be removed because...

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Removal
*.domain_name_here   CNAME . ; Removal
```

## Reason
<!-- Try to convince the team of why this domain should be added to the
removal job -->

## Comments
<!-- Paste any relevant logs - please use code blocks (```) to format
console output, logs, and code as it's very hard to read otherwise. -->

## Screenshots


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

#### Adblocker
<details><summary>Click to expand</summary>

```css
N/A
```

</details>


## My Privacy DNS issues
- `` #

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

### Todo:
  - [ ] Added to Source file
  - [ ] RPZ Server  (Team @Spirillen)

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"

/label ~"Removal::False Positive"

/weight 6

/publish

/severity s4

/health_status on_track
