<!-- Find tips in the bottom -->

I believe this domain is a Strict Adult(-related) domain --> that have to be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking


```css
domain   CNAME . ; Strict.Adult
*.domain   CNAME . ; Strict.Adult
```

### Additional requirements for hosts and Pi-hole

```css
null
```

```css
+ www
- www
www.?
```

## Relevant logs or comments
<!-- comments like a specific url to see contents -->

## Relevant External sources
<!-- If you found this domain on another issueboard -->

## Screenshots

<details><summary>Screenshot</summary>



</details>

### All Submissions:
- [x] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) documentation?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the
      same update/change?
- [x] Added screenshot for proof of False Negative

### Todo
- [ ] Added to Source file?
- [ ] Added to the RPZ zone [strict.adult.mypdns.cloud](https://mypdns.org/mypdns/support/-/wikis/RPZ-List#strictadultmypdnscloud) (@spirillen)

#### Logger output

<details><summary>3rd party Domains</summary>

```python
N/A
```

</details>


/assign @spirillen 

/label ~"NSFW::Strict"


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


<!-- Template url:https://mypdns.org/my-privacy-dns/porn-records/-/issues/new?issuable_template=Strict%20Adult%20contents -->
