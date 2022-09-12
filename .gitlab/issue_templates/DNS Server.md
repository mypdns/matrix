I believe this [DNS Server][dnsserver] needs to be be added into the [MyPDNS RPZ Firewall][mpdrf]

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
*.example.org.rpz-nsdname   CNAME . ; DNSServer
24.0.2.3.4.rpz-nsip   CNAME . ; DNSServer
```

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

## Screenshots


## Comments
<!-- Be as clear as possible: nobody can read your mind, and nobody is looking at your issue over your shoulder. -->

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
- [ ] RPZ Server (Team \@Spirillen)
- [ ] Added to Source file

#### Logger output

<details><summary>3rd party Domains</summary>

```python
N/A
```

</details>

<details><summary>**_Help Note_**:</summary>

```python
# blocking an NS IPv4 address of 192.0.2.3
# rewritten as 192.0.2.3/32
# IPv4 NSIP Trigger transform
32.3.2.168.192.rpz-nsip

# blocking an NS IPv6 address of 2001:db8:0:1::57
# rewritten as 2001:db8:0:1::57/128
# IPv6 NSIP transform
128.57.zz.1.0.db8.2001.rpz-nsip
```
</details>

[dnsserver]: https://mypdns.org/mypdns/support/-/wikis/RPZ-record-types#the-nsdname-trigger-rpz-nsdname
[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/ "My Privacy DNS RPZ Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"

/label ~DNS_Server

/weight 7

/publish

/severity medium

/health_status needs_attention
