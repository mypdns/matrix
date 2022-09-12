I report this ~"NSFW::Porn" related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Adult
*.domain_name_here   CNAME . ; Adult
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

#### Adblocker
<details><summary>Click to expand</summary>

```css
N/A
```

</details>


## Screenshots

<details><summary>:underage: NSFW Screenshot :underage:</summary>



</details>

## Relevant comments


## My Privacy DNS issues
- `` #

## External sources
- ``

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) documentation?
- [X] Added [screenshot] for prove of [False Negative][FN]
- [X] Added screenshot for proof of False Negative

### Todo
- [X] Added to Source file?
- [X] Added to the RPZ zone [adult.mypdns.cloud][adultmypdnscloud] (spirillen)

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
