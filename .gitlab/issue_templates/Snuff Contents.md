I report this ~"NSFW::Snuff" related domain(s) to be added into the [MyPDNS RPZ Firewall][mpdrf]

- [X] Wildcard
- [ ] Individual domain blocking


## RPZ (Response Policy Zone) Rules

```css
domain   CNAME . ; Snuff
*.domain   CNAME . ; Snuff
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

<details><summary>:underage: NSFW Screenshot :underage:</summary>



</details>

## Comments
<!-- comments like a specific url to see contents -->

## My Privacy DNS issues
- #

## External sources
<!-- If you found this domain on another issueboard -->
- ``

### All Submissions:
- [ ] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) documentation?
- [ ] Added [screenshot] for prove of [False Negative][FN]
- [ ] Added screenshot for proof of False Negative

### Todo
- [ ] Added to Source file?
- [ ] Added to the RPZ zone [adult.mypdns.cloud](https://mypdns.org/mypdns/support/-/wikis/RPZ-List#adultmypdnscloud) (@spirillen)

#### Logger output

<details><summary>3rd party Domains</summary>

```python
N/A
```

</details>


 /label ~"NSFW::Snuff" 


<!-- Template url:https://mypdns.org/my-privacy-dns/porn-records/-/issues/new?issuable_template=Snuff -->

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"
