_API_:    [Basic](guide_api.md) | [**Advanced**](guide_apiadv.md)

----


_This guide is for developers who already know the basics._


## API URL

We provide additional 3 API for My Privacy DNS: `cat`, `committer` and `issue` endpoint.

- [**`cat`** API](guide_apiadv.md#the-cat-api) provide `Issue CATegory` and `labels` for requested domain.
- [**`committer`** API](guide_apiadv.md#the-committer-api) provide services to _Committer website_.
- [**`issue`** API](guide_apiadv.md#the-issue-api) provide issue-editing service.


| Type     | URL                                                                                       |
| -------- | ----------------------------------------------------------------------------------------- |
| Clearnet/Tor | cat: `https://mypdns.eu.org/api/cat/`<br>committer: `https://mypdns.eu.org/api/committer/`<br>issue: `https://mypdns.eu.org/api/issue/`                                        |

There are too many so we pick up some of useful actions below.


## The `cat` API

> **Get issue category and labels of the domain**

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `f` FQDN (e.g. `www.youtube.com`)<br>[Optional] `wcf` Existence (if set: when the `f` is Cloudflare 'Cloudflare' will be added to the labelName response) |
| Output | JSON value as array<br>`[catName, [labelName1,labelName2..]]` (catName is API cat value e.g. _porn_)<br>`['',[]]` (if issue is not exist or error) |
| Example | `curl -X POST -F 'f=gist.github.com' -k --http2 [API_URL]` |

## The `committer` API

- `k` (Access token _`read_user + api`_) is required.

> **Get Issues which you did not take action yet**

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = getjob`<br>`resp` JSON array search keyword (e.g. nothing or `AS13335`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem with your request)<br>`[true, [resultArray]]` the `resultArray` contains `iid`(IssueID) `cat`(CATegory) `domain`(Domain) `ss`(ScreenshotURL) `body`(HTML) |
| Example | `curl -X POST -F 'act=getjob' -F 'k=XXXXXX' -F 'resp={"search":""}' -k --http2 [API_URL]`<br>`curl -X POST -F 'act=getjob' -F 'k=XXXXXX' -F 'resp={"search":"AS13335"}' -k --http2 [API_URL]` |

> **Update the issue with your answer**

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = answer`<br>`resp` JSON array `id`(IssueID) and `act`<br>(`act` is _one of_: `screenshot` `pirated` `wontfix` `commit` `change2(catNameHere)`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem with your request)<br>`[true, 'OK']` Success |
| Example | `curl -X POST -F 'act=answer' -F 'k=XXXXXX' -F 'resp={"id":"12345","act":"screenshot"}' -k --http2 [API_URL]`<br>`curl -X POST -F 'act=answer' -F 'k=XXXXXX' -F 'resp={"id":"23456","act":"change2coinblocker"}' -k --http2 [API_URL]` |

> **[Gallery mode] Get screenshot URLs**

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = galleryget`<br>`resp` JSON array `page number` and `search keyword` (e.g. nothing or `AS13335`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem with your request)<br>`[true, [resultArray]]` the `resultArray` contains `iid`(IssueID) `domain`(Domain) `ss`(ScreenshotURL) `cat`(CATegory) |
| Example | `curl -X POST -F 'act=galleryget' -F 'k=XXXXXX' -F 'resp={"page":1,"search":""}' -k --http2 [API_URL]`<br>`curl -X POST -F 'act=galleryget' -F 'k=XXXXXX' -F 'resp={"page":2,"search":"AS13335"}' -k --http2 [API_URL]` |

> **[Gallery mode] Report issue as**

- This is similar to _`Update the issue with your answer`_.

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = gallerybad`<br>`resp` JSON array `id`(IssueID) and `type`<br>(`type` is _nothing_(mark as bad screenshot) **or** _one of_: `pirated` `wontfix` `commit`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem with your request)<br>`[true, 'OK']` Success |
| Example | `curl -X POST -F 'act=gallerybad' -F 'k=XXXXXX' -F 'resp={"id":"12345","type":""}' -k --http2 [API_URL]`<br>`curl -X POST -F 'act=gallerybad' -F 'k=XXXXXX' -F 'resp={"id":"23456","type":"pirated"}' -k --http2 [API_URL]` |

## The `issue` API

- `k` (Access token _`read_user + api`_) is required _except_ `act=get`.

> **Get IssueID of the domain**

- `k` is not necessary. Adding it to the request has no effect.
- This is used by _Listed or not_ website.

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `act = get`<br>`f` FQDN (e.g. `www.youtube.com`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem)<br>`[true, IssueID]` (IssueID may return `0` when there is no issue) |
| Example | `curl -X POST -F 'act=get' -F 'f=gist.github.com' -k --http2 [API_URL]` |

> **Read Issue Comments**

- If your token is Superuser the response has extra data: `open` and `img`.

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = read`<br>`f` `IssueID.example.org` (e.g. `12345.example.org` for `Issue 12345`) |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem)<br>`[true, dataArray]`<br>dataArray contains `name`(Your username) `sudo`(Your Superuser status) `avatars`(if the user has Avatar) `comments`.<br>If you are superuser it also contains `open`(Issue is opened or not) `img`(Screenshot URL). |
| Example | `curl -X POST -F 'act=read' -F 'k=XXXXXX' -F 'f=123456.example.org' -k --http2 [API_URL]` |

> **Add your comment**

| ? | ? |
| -- | -- |
| Request Method | POST |
| Input | `k` Access Token<br>`act = write`<br>`f` `IssueID.example.org` (e.g. `12345.example.org` for `Issue 12345`)<br>`body` UTF-8 encoded string |
| Output | JSON value as array<br>`[false, stringReason]` (if there is a problem)<br>`[true, true]` Success |
| Example | `curl -X POST -F 'act=write' -F 'k=XXXXXX' -F 'f=123456.example.org' -F 'body=XXXXX'-k --http2 [API_URL]` |
