I believe this domain is an [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Adware) domain(s) --> that have to be blocked as..

- [ ] Wildcarded
- [x] Single domain blocking

```python
domain   CNAME . ; Phishing
*.domain   CNAME . ; Phishing
```

## Relevant logs and/or screenshots
- https://github.com/mitchellkrogza/phishing/pull/78


## Screenshots
<details><summary>Click to unfold</summary>

![Screenshot of phishing domain copyright-communit-rules.xyz](https://user-images.githubusercontent.com/91695795/136650486-e47a3461-90d4-4c4f-a4bb-4800e27849b5.png)

</details>

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the
      same update/change?
- [X] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~Phishing

/weight 10

/publish

<!-- template link https://mypdns.org/my-privacy-dns/matrix/-/issues/new?issuable_template=-aa -->
