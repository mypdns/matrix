I report this [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Categories/Adware) related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(please input basedomain here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; AdWare
*.domain_name_here   CNAME . ; AdWare
```

## Relevant comments
Adserver found at ``

## Screenshots
<details><summary>Click to expand</summary>

![Screeshot]()

</details>


## My Privacy DNS issues
- `` #

## External sources
```

```

### All Submissions:
- [X] Did you follow the guidelines in the [Contributing](CONTRIBUTING.md)
	  document?
- [X] Have you checked to ensure there aren't other open
      [Merge Requests (MR)][NR] or [issues] for the
      same domain?
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [X] Added [screenshot] for prove of [False Negative][FN]

### Testing phase
- [X] Checked the internet for verification?
- [X] Successfully tested changes locally?

### Todo
- [X] RPZ Server (Team \@Spirillen)
- [X] Added to Source file

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"

/label ~AdWare

/weight 6

/health_status needs_attention

/severity low

/publish
