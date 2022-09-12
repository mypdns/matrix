<!-- Find tips in the bottom -->

I report this ~"NSFW::Porn" related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(please input basedomain here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; CSAM, Adult
*.domain_name_here   CNAME . ; CSAM, Adult
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
<details><summary><b><i>NSFW</b></i> Screenshot</summary>

Not used for CSAM

</details>


## Comments
<!-- comments like a specific url to see contents -->

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

### Todo
- [ ] Added to Source file?
- [ ] Added to the RPZ zone [adult.mypdns.cloud][adultmypdnscloud] (spirillen)

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

/label ~"NSFW::Porn" ~CSAM

/confidential 

/weight 10

/health_status at_risk

/severity critical

/publish

<!--
usage of www or not

Please check if you submission is using the the www or not
and put that into the section

You can tell us you have checked this by adding either a {key +}, a {key -} or `none` in front of the `www`

+ www  The domain uses **both** the `www` and the _none_ `www` names.
- www  The domain is not using `www` name _or_ `www` is redirecting.
www.domain  The domain uses **only** the `www.` name.
www.? Leaving the question mark tells us you haven't tested this

Tips & Tricks

If you are using ie. uBlock Origin, you can sort the log output with this
one-liner in bash.
See snippet: https://mypdns.org/-/snippets/30
-->
