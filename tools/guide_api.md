_API_:    [**Basic**](guide_api.md) | [Advanced](guide_apiadv.md)

----


## About API Token scope

To use this service you need `MyPDNS.org` API Token. This is for preventing
abusive requests.

The API Token requires **`read_user`** permission to read `account status`
(banned or not) and  `username on mypdns.org`. Other information such as
your email address is NEVER be read or collected.

There is another _optional_ permission, `api`. If you enable it the bot
will automatically `add your vote to already existing issue` for
voting-based priority. Also you can `add your comment from add-on directly` without logged in. It is not required although it will help
maintainers to decide their priority.
(The `committer` website will misbehave if you do not have `api` permission)


## API

Just send a URL and it will turn into useful issue!

Clearnet & Tor:

```
curl --http2 -d "k=yourApiTokenHere&cat=news&url=https://nytimes.com/" -X POST https://apiUrlHere
```


- Change `k` to your personal access token.
  - e.g. `k=byIe_ns-39cWCQ` (_not `k="ab-Cd_E"` nor `k='a_bc-DE'`_)
- Change `url` to the URL such as: `https://porn.com/lesbian.html`


### API URL

| Type     | URL                                                                                       |
| -------- | ----------------------------------------------------------------------------------------- |
| Clearnet/Tor | `https://mypdns.eu.org/api/reporting/`                                        |


### POST data

| required?          | name  | value                                                                                                        |
| ------------------ | ----- | ------------------------------------------------------------------------------------------------------------ |
| :heavy_check_mark: | k     | **K**ey. MyPDNS Token (`read_user + api` _or_ `read_user` permission)                                                                                          |
| :heavy_check_mark: | url   | Full URL of the website. If you do not know the URL just add `https://` or something (discouraged for good screenshot)                                                                                     |
| :heavy_check_mark: | cat   | Category of the website<br>(the `cat` value _OR_ `in Matrix` value) |
| :heavy_minus_sign: | wmemo | **Optional** Comment. UTF-8 encoded string                                                               |
| :heavy_minus_sign: | wdesc | **Optional** Existence. If set & there is already an issue, the reply value will be the issue's description. |
| :heavy_minus_sign: | byme | **Optional** Existence. If set, issue will be created using your token instead of reporter's. |


### The `cat` value

| Category            | Case-Sensitive format           |
| ------------------- | ------------------------------- |
| adware              | `AdWare`                        |
| coinblocker         | `CoinBlocker`                   |
| drugs               | `Drugs`                         |
| gambling            | `Gambling`                      |
| malicious           | `Malicious`                     |
| movies              | `Movies`                        |
| news                | `News`                          |
| phishing            | `Phishing`                      |
| pirated            | `Pirated`                      |
| politics            | `Politics`                      |
| religion            | `Religion`                      |
| scamming            | `Scamming`                      |
| spyware             | `Spyware`                       |
| torrent             | `Torrent`                       |
| tracking            | `Tracking`                      |
| typosquatting       | `Typo_Squatting`                |
| urlshortener        | `Redirector` or `Url_Shortener` |
| weapons             | `Weapons`                       |
| ------------------- | ------------------------------- |
| porn                | `NSFW::Porn`                    |
| porngore            | `NSFW::Gore`                    |
| pornsnuff           | `NSFW::Snuff`                   |
| pornstrict          | `NSFW::Strict`                  |


- The response is _always_ JSON.
  - Response _always_ have `reply` key (and `issue` key when the issue is already exist)
  - For example the return value `{'reply':'roger'}` means it accepted your request.
- After some minutes later your issue will appear on Matrix issues (or 
  not, if the issue is already exist or unable to take a screenshot)
  - If there are many submissions this might take hours. You can know 
    your requests are still in line by sending same request again. API
    will reply "`This domain is still waiting in line.`".
- If you are going to report CSAM (aka Child Porn) website add the word 
  `CSAM` to the comment.
  - The issue will be created with Confidential flag.
