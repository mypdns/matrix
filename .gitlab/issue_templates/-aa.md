> This issue is committed via our add-on.

@${USER} believe this domain should be reported as ${$cat1, $cat2}

-------------------
`Alternative intro`
@${USER} believes this domain should be reported
-------------------

```
$DOMAINs
```

- [X] Wildcarded
- [ ] Single domain (Only sub domains) (Comment: Sub.$domain can be wildcarded as well!!!)

(!Comment: we prefer blacklisting by wildcard as much as possible)
```css
$DOMAIN   CNAME . ; $cat1 elif , $cat2 # other comment
*.$DOMAIN   CNAME . ; $cat1 elif , $cat2 # other comment
```

```
IF [ ISSUE == Porn Record ]
THEN
	### Additional requirements for hosts and Pi-hole

	```css
	IF [ ! -n sub.$domain ]
	THEN
		sub.$domain
		sub1.$domain
		...
		sub829.$domain
	ELSE
		null
	FI
	```

	```css
	+ www (HTTP 200 on both $DOMAIN & www.$DOMAIN)
	- www (HTTP 200 only on $DOMAIN )
	www.$DOMAIN (HTTP 200 only on www.$DOMAIN)
	```
FI
```

## Relevant comments


## Screenshots
<details><summary>Screenshot</summary>

![ScreenShot]($IMAGE.webp)

</details>

## Relevant External sources

(Comment: External urls should always be covered in backticks to avoid
generating unwanted links)

- `https://www.intezer.com/blog/malware-analysis/new-backdoor-sysjoker/`
- `https://github.com/blocklistproject/Lists/issues/623`

#### Test URL
```
${REPORTED_URI}
```

#### IP Information
```
$DOMAIN = $IP [$COUNTRY]
ASN: $ASN_INFO
```

#### 3rd party Domains
```
$3P_DOMAIN(S)
```

> Linked issues

- [facebook.com](https://mypdns.org/my-privacy-dns/matrix/-/issues/1728)
- [scorecardresearch.com](https://mypdns.org/my-privacy-dns/matrix/-/issues/502)
- [wp.com](https://mypdns.org/my-privacy-dns/matrix/-/issues/4515)
- [youtube.com](https://mypdns.org/my-privacy-dns/matrix/-/issues/3868)

### All Submissions:
- [ ] Did you follow the guidelines in the [Contributing](CONTRIBUTING.md)
	  document?
- [ ] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../../issues) for the
      same domain?
- [ ] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [X] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)

### Testing phase
- [ ] Checked the internet for verification?
- [ ] Successfully tested changes locally?

(!Comment: IF = Possible, then make this unmarked until actually committed and have
the post officer (bot) to mark the fixed once. We can maybe use the gitlab
runner for this job, to offload your server(s))

### Todo
- [X] RPZ Server
- [X] Added to Source file

/label ~$cat1 ~$cat2 ~$cat3

```
IF = issue
/weight $WEIGHT (Only in issues, based on category)

ELIF = INCIDENT

/severity $Severity (Only on incident, based on category)

fi
```

/publish
