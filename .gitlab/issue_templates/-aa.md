I believe this domain is an [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Adware) domain(s) --> that have to be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking

```python
domain   CNAME . ; AdWare
*.domain   CNAME . ; AdWare
```

## Relevant logs and/or screenshots
- `https://github.com/easylist/easylist/pull/9682`

## Screenshots
<details><summary>Click to unfold</summary>

![Screenshot](https://user-images.githubusercontent.com/65717387/141348959-a530ccb4-9aef-47bf-bdcf-e0036252fc3c.png)

![Screenshot](https://user-images.githubusercontent.com/65717387/141349460-ca039c09-1138-478f-8bc4-402c6ee0f496.png)

![Screenshot](https://user-images.githubusercontent.com/65717387/141349483-8a799116-98ae-4420-8d78-d3a42da29eb8.png)

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

/label ~AdWare

/weight 2

/publish
