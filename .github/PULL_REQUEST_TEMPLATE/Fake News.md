---
name: Fake News
about: Submitting new Fake News domains
title: Fake News
labels: Fake News
assignees: AnonymousPoster, spirillen

---

## Summary

<!-- Keep any domains in back ticks `(`)`

Screenshot is required within the <details> pane. Leave a blank line before
and after the image link -->

This domain hosts 'Fake News' that have to be blocked as..

- [x] [Wildcarded](source/fake-news/wildcard.list)
- [ ] [Single domain blocking](source/fake-news/domains.list)

```python
example.org   CNAME . ; FakeNews
*.example.org   CNAME . ; FakeNews
```

... ***because***:

## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format
console output, logs, and code as it's very hard to read otherwise. -->

## Screenshots

<details><Summary>Screenshot required</summary>



</details>

### All Submissions:
- [ ] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) document?
- [ ] Have you checked to ensure there aren't other open [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the same update/change?
- [ ] Added ScreenDump for prove of False Positive
- [ ] Have you added an explanation of what your submission do and why you'd like us to include them??

### Testing face
- [ ] Checked the internet for verification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server (Team @Spirillen)
- [ ] Added to Source file
