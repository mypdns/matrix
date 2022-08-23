<!-- Find tips in the bottom -->

I report this ~"CDN::NSFW-Strict" related domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

```
(please input basedomain here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain   CNAME . ; Adult
*.domain   CNAME . ; Adult
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

#### uBlock Origin adblocker
<details><summary>Click to expand</summary>

```css
N/A
```
</details>

## My Privacy DNS issues

## Comments
<!-- comments like a specific url to see contents -->

## My Privacy DNS issues
- #

## External sources
<!-- If you found this domain on another issueboard -->

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) documentation?
- [ ] Added [screenshot] for prove of [False Negative][FN]

### Todo
- [ ] Added to Source file?
- [ ] Added to the RPZ zone [strict.adult.mypdns.cloud] (\@spirillen)

 

/label ~"CDN::NSFW-Strict"

<!--
usage of www or not

Please check if you submission is using the the www or not and put that into
the section of

You can tell us you have checked this by adding either a {key +}, a {key -} or `none` in front of the `www`

+ www  The domain uses **both** the `www` and the _none_ `www` names.
- www  The domain uses **only** the _none_ `www` name.
www.domain  The domain uses **only** the `www.` name.
www.? Leaving the question mark tells us you haven't tested this

Tips & Tricks

If you are using ie. uBlock Origin, you can sort the log output with this
one-liner in bash.
See snippet: https://mypdns.org/-/snippets/30
-->

[FN]: https://mypdns.org/MypDNS/support/-/wikis/False-Negative "About False Positive"
[hosts]: https://mypdns.org/mypdns/support/-/wikis/dns/DnsHosts "Hosts files a outdated blacklist format"
[issue]: https://mypdns.org/my-privacy-dns/matrix/-/issues "My Privacy DNS Domain records"
[mpdrf]: https://mypdns.org/my-privacy-dns/matrix/-/tree/master/source/porn_filters "My Privacy DNS RPZ Parental Firewall Filter"
[MR]: https://mypdns.org/my-privacy-dns/matrix/-/merge_requests "My Privacy DNS Merge Requests"
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole
[Pi-hole]: https://mypdns.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole "What is Pi-hole and it limitations"
[screenshot]: https://mypdns.org/MypDNS/support/-/wikis/Screenshot "What is a screenshot"
[strict.adult.mypdns.cloud]: https://mypdns.org/mypdns/support/-/wikis/RPZ-List#strictadultmypdnscloud
