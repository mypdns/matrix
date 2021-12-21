I believe this domain is an [AdWare](https://mypdns.org/MypDNS/support/-/wikis/Adware) domain(s) --> that have to be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking

```python
domain   CNAME . ; AdWare
*.domain   CNAME . ; AdWare
```

## Relevant comments
Adservers responsible for redirects and popups on `strtpe.link`

Big thanks to @felippesantos46 and @ryanbr at `https://github.com/easylist/easylist/pull/10130` for sharing there observations.

## Screenshots
<details><summary>Click to expand</summary>

![Screeshot](https://user-images.githubusercontent.com/65717387/146549892-1194cf1f-f7cc-4e69-b771-a6137c17145a.png)

![Screeshot](https://user-images.githubusercontent.com/65717387/146549899-63b84406-fa23-4b29-a4af-c1497370bc7a.png)

![Screeshot](https://user-images.githubusercontent.com/65717387/146549903-bea4fb98-d63b-48ce-b400-cc2294a98487.png)

![Screeshot](https://user-images.githubusercontent.com/65717387/146737237-e7c6c8df-ec71-446f-998a-64e00941fb16.png)

![Screeshot](https://user-images.githubusercontent.com/65717387/146737256-93c153ff-74d4-41d8-aef0-03270e849eae.png)

</details>

## Relevant External sources
- `https://github.com/easylist/easylist/pull/10130`

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the
      same update/change?
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [X] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~AdWare

/weight 2

/publish
