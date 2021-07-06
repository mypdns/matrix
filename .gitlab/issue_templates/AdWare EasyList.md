I believe this domain is an [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Adware) domain(s) --> that have to be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking

```python
domain   CNAME . ; AdWare
*.domain   CNAME . ; AdWare
```

## Relevant logs and/or screenshots
A big thank you to @ryanbr in <https://github.com/easylist/easylist/commit/24d8c4ebf4990e9df2d089b41e3c692a374a2cd6>

Fixed in:
  - --
  - --

Thanks to @smed79 in https://github.com/easylist/easylist/pull/5523
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

/label ~AdWare

/assign @Spirillen

/weight 1

/publish
