This is an easy way to commit `new websites` to [Matrix Issues](https://mypdns.org/my-privacy-dns/matrix/-/issues).



**Waiting in Line**: ![status image](https://status.mypdns.org/waiting.svg)


--------

From the time you have committed a domain / uri you can see it as a
committed issue is depending on the current queue for handling of your
request, [the server](http://crimeflare.eu.org) then process and
validating your contribution towards some simple rules like below and
then issue will be created.

- Is the website `online`?
- Is the domain `not listed in files`?
- Is the `issue` not exist?
- Is the domain `not parked`?
- Is the `screenshot` ready?

Process flow: `Taking the screenshot`, `Reading the website`,
`Checking DNS` and `Searching for existing issues within mypdns.org` for
_each_ request cost some time.  
Because of this your requests might take several hours depending on
current wait-in-line status.  
You will find your issue later on your To-do list.

```
Reporter mentioned you on issue #XXX "example.com" at My Privacy DNS
```

- By using this service you agree to our [Privacy Policy](privacy_policy.md).
- [Leaderboard](leaderboard.md)

## Clients

| CLI | GUI | Add-ons | Websites |
| -- | -- | -- | -- |
| [![](.assets/lp/cli.png)](client/cli.md) | [![](.assets/lp/gui.png)](client/gui.md) | [![](.assets/lp/addon.png)](client/addon.md) | [![](.assets/lp/web.png)](https://mypdns.org/matrix/committer/)<br>[![](.assets/lp/web.png)](https://mypdns.org/matrix/reporter/) |

## For Developers

- [Basic API Guide](guide/api.md)
- [Advanced API Guide](guide/apiadv.md)

--------

#### TOC

- [Control your issue](#control-your-issue)
  - [All users](#all-users)
  - [Super users ONLY](#super-users-only)

------

## Control your issue

You can close, reopen, or rescan your issue created **by you**.
Just write a comment in issue and it will be handled quickly.

You cannot control other user's issue _except_  [Super users](lists/su.txt).

### All users

| Comment                                                          | Result                        |
| ---------------------------------------------------------------- | ----------------------------- |
| `@reporter /close`                                               | Close this issue.             |
| `@reporter /reopen`                                              | Reopen this issue.            |
| `@reporter /update URL`<br>`@reporter /update` (=`/update this`) | Update the issue description. |


### Super users ONLY

| Comment                                                                                        | Result                                                                                                                                             |
| ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@reporter /invalid`                                                                           | Set `Invalid` label & close the issue.<br>(same as `/label Invalid` + `/close`)                                                                    |
| `@reporter /wontfix`                                                                           | Set `Wontfix` label & close the issue.<br>(same as `/label Wontfix` + `/close`)                                                                    |
| `@reporter /label LABEL`                                                                       | Set `LABEL` label. Comma-separated, Case-Sensitive.<br>e.g. `/label Linked,Tracking`                                                               |
| `@reporter /pirated`                                                                           | Set `Pirated` label.<br>(same to `/label Pirated`)                                                                                                 |
| `@reporter /change category URL`<br>`@reporter /change category`<br>(=`/change category this`) | Change the category and update the issue with a new issue format.                                                                                  |
| `@reporter /include category URL`<br>`@reporter /include guess URL` | Add/Update new subdomain to exisiting issue.<br>The "_guess_" category will use the primary reported category.                                                                                  |
| `@reporter /ss`                                           | Add `Need::Screenshot` label.                                          |
| `@reporter /translate URL`<br>`@reporter /translate` (=`/translate this`)                                           | Translate the website into English.                                          |
| `@reporter /investigate`                                           | Investigate the issue domain.                                       |
| `@reporter /crawl` | Download & analyze reported website for links. |
| `@reporter /commit`<br>`@reporter /ok`                                                         | Commit this issue                                                                                                                                  |
| `@reporter /csam` | Turn on confidential,<br>Remove screenshot,<br>Add CSAM label,<br>and Commit the issue. |


You can remove the first `/`. For example `@reporter close` is identical
to `@reporter /close`.

If the command is not actionable the bot will add `!` as reaction.


> **About `this` URL**
- If you are going to update or change current issue _with same URL_, you 
  can write `this` for URL.
  - This does not work with issues which does not include the URL 
    inside the description. (very old issue or user-created issue)

> **About `/update URL`**
- The URL's base domain must match the title's domain.
  - e.g. `@reporter /update https://blog.example.com` for updating
    `example.com` issue
- You can also write
    ```
    @reporter /update https://blog.example.com/blog/
    ```
  (The \` will be ignored automatically)

> **About `/change category URL`**
- The `category` value is [listed here](guide/api.md#the-cat-value) - pick either `Category`(recommend) or `Case-sensitive format`
- For example if you want to resubmit `Porn` issue as `NSFW::Strict`, 
  you will write `@reporter /change pornstrict https://www.example.com`.
