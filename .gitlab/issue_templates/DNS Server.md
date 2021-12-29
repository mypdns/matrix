I believe this DNS Server needs to be blocked as...

- [X] Wildcarded
- [ ] Single domain blocking

```python
*.example.org.rpz-nsdname   CNAME . ; DNSServer
24.0.2.3.4.rpz-nsip   CNAME . ; DNSServer
```

## Relevant comments
<!-- Be as clear as possible: nobody can read your mind, and nobody is looking at your issue over your shoulder. -->


## Screenshots


## Relevant External sources
- ``
- ``

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../../issues) for the
      same update/change?
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [ ] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)

### Testing face
- [ ] Checked the internet for verification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server (Team @Spirillen)
- [ ] Added to Source file

**_Note_**:

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

/label ~"DNS Server"

/assign @spirillen

/weight 2

/publish

/severity medium
