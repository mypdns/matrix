I believe this domain is an [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Adware) domain(s) --> that have to be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking

```python
domain   CNAME . ; AdWare
*.domain   CNAME . ; AdWare
```

## Relevant logs and/or screenshots
This domain have been reported for ~Tracking by @rugabunda and pasted on by @r-a-y with the following words:

These are fresh 5 month old domains, obfuscated to not appear associated with kochava, and very little info on them, but I dug deep and found they are all related to kochava analytics.

Most of the above were calling out from my mobile. https://threatcrowd.org/domain.php?domain=int.vaicore.xyz

Note "URL analysis, under "network analysis" on this page https://beta.pithus.org/report/844aa271ef47f7807ab3ccc63952e2215298701a6851857c22456317927f08fd

This one particular app uses tracker querys Defined in `com/kochava/base/m.java`

```
https://kvinit-prod.api.kochava.com/track/kvinit
https://int.dewrain.life/track/kvinit
https://int.vaicore.site/track/kvinit
https://int.akisinn.info/track/kvinit
https://int.dewrain.site/track/kvinit
https://int.akisinn.site/track/kvinit
https://int.vaicore.xyz/track/kvinit
https://int.vaicore.store/track/kvinit
https://int.dewrain.world/track/kvinit
```

It should be noted that some of the apk files associated with these domains are high risk; https://www.virustotal.com/gui/domain/int.vaicore.site/relations


Please find more details in either https://mypdns.org/my-privacy-dns/matrix/-/issues/2502 or in one of the external source:

  - https://github.com/AdguardTeam/AdguardFilters/issues/93230
  - https://github.com/r-a-y/mobile-hosts/issues/16
  - https://github.com/AdAway/adaway.github.io/issues/281

## Screenshots


### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the
      same update/change?
- [ ] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~Tracking

/assign @Spirillen

/weight 2

/publish

<!-- template link https://mypdns.org/my-privacy-dns/matrix/-/issues/new?issuable_template=-aa -->
