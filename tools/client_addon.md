_Clients_:    [CLI](client_cli.md) | [GUI](client_gui.md) | [**Add-ons**](client_addon.md) | [Website](client_web.md) | [Mail](client_mail.md)

----

📢 Looking for [Crimeflare (deCloudflare)'s Add-ons](https://0xacab.org/my-privacy-dns/deCloudflare/-/blob/master/addons/README.md) instead?


# Browser Add-ons

- [MyPDNS Reporter](client_addon.md#mypdns-reporter) for _reporting_ domains
- [MyPDNS Defender](client_addon.md#mypdns-defender) for _blocking_ domains
- [MyPDNS Screenshot Assistant](client_addon.md#mypdns-screenshot-assistant) for _taking screenshots_ to improve Matrix issues
- [MyPDNS Link Details](client_addon.md#mypdns-link-details) for _easily spot on links_ before click


----
----

# MyPDNS Reporter

### Usage
  - Right-click the page or link and you will find a report button.
  - You can include small details(memo) or related links.
  - Read/Write user comments with just one click.

### Build in smart command features

Say you are going to report `www.example.com`.
You put the below text to add-on/CLI/GUI and tried to report.

```
this site is cloudflare infected! same as https://cloudflare.com/blog!!
https://welcome.example.com/blog/about/it.html
https://example.org
https://example.org/
https://example.net/siteinfo/about/example
https://example.net/siteinfo/about/example
https://example.net/siteinfo/about/example
oh my this is long report.
```

The result will be:

```
> Memo
this site is cloudflare infected! same as https://cloudflare.com/blog!!
https://welcome.example.com/blog/about/it.html
https://example.org
https://example.org/
oh my this is long report.

## Relv Ext Sources
- `https://example.net/siteinfo/about/example`
```

And here is a reason:

- `https://cloudflare.com/blog`: This _line_ does not start with HTTP link (`this site is...`), thus ignored.
- `https://welcome.example.com/blog/about/it.html`: It is same basedomain (Same as `example.com` you are reporting), therefore it is not _external_ sources. Ignored.
- `https://example.org` and `/`: This URL has no path. The URL is not pointing at useful webpage, therefore it is ignored (& treated as memo).
- `https://example.net/siteinfo/about/example`: It is hosted on exteral sources (not same base domain)
  - Also duplicated URLs will be merged into one.

### Download Browser Add-on

- Firefox
  - [**Download from My Privacy DNS**](https://mypdns.eu.org/dl/addon/reporter.xpi)


```
Version: 1.0.3.3
What is changed from previous?

- raw ip support
```

### Screenshots

| ? | ? | ? |
| -- | -- | -- |
| ![Sidebar with room for adding comment](../.assets/reporter/img/ffaddon-1.webp) | ![Right cllick menu options](../.assets/reporter/img/ffaddon-2.webp) | ![popup instead of sidebar](../.assets/reporter/img/popup.webp) |


----
----

# MyPDNS Defender

### Usage
- Block websites using MyPDNS lists file
- Auto-update lists once per day (disabled by default)

### About list update
- The add-on use browser cache to prevent DDoS against Gitlab. You can check for update once per hour.
  - Clicking "_Apply my settings_" multiple times only download once.
  - If you _really_ want to download latest list try again in next hour. (e.g downloaded at 8AM, try again in 9AM)

### About Options
- Whitelist
  - Input `base domain` or `FQDN` to whitelist it.
    - If you input `example.org`, all `(|*.)example.org` will be ignored.
    - If you input `blog.example.net`, just `blog` will be ignored (and add-on still block `www.example.net`)
- Include .onion domain list
  - This is only useful to Tor user (e.g. Tor Browser)
  - When enabled & some categories are selected, the add-on will download & read `onions.list`.

### Download Browser Add-on

#### Firefox
  - [**Download from My Privacy DNS**](https://mypdns.eu.org/dl/addon/defender.xpi)


```
Version: 1.0.0.8
What is changed from previous?

- minor change
```


----
----

# MyPDNS Screenshot Assistant

### Usage
This add-on is for updating those [Bad screenshot Issues](https://0xacab.org/my-privacy-dns/matrix/-/issues/?label_name%5B%5D=Need%3A%3AScreenshot). Since there are many anti-bot solutions and services, the quality of the screenshot created by bot is degraded by them. Cetralized screenshot services is always bad because the website can block it by script or IP address.

With your help, those issues can get fresh, clean screenshot. All the add-on need is just one Window (and _clean_ internet). So, what will this add-on do?

1. Load 1 `Need::Screenshot` issue.
2. Load the website and take a screenshot.  (automated action of _you open the reported website and click Reporter Sidebar's `Replace Issue Screenshot` command_)
3. Edit the issue to add new information.  (`New Screenshot` _or_ `cannot connet comment` will be added)

You need _Superuser_ permission to use this add-on because this add-on _edit_ original issue.
All you have to do is,

1. Click Cat icon (toolbar)
2. Resize the window (e.g. 800x800)
3. Input your API token (_only for the first time - add-on will remember this_)
4. Click Start


### Download Browser Add-on

#### Firefox
  - [**Download from My Privacy DNS**](https://mypdns.eu.org/dl/addon/screenshot.xpi)


```
Version: 1.0.0.4
What is changed from previous?

- minor change
```

----
----

# MyPDNS Link Details

### Usage
There are many links in your friend's blog or social media. As a noob, you just do not know whether those links are evil or not. This add-on automatically do the job for you by looking up Project Matrix and mark bad links on your behalf. This add-on does not make unnecessary connection because the result will be saved locally for some weeks.

If this is the first time you use this add-on, you might need to close the browser and open again (restart browser).


### Download Browser Add-on

#### Firefox
  - [**Download from My Privacy DNS**](https://mypdns.eu.org/dl/addon/linkdetails.xpi)


```
Version: 1.0.0.7
What is changed from previous?

- add whitelist option
```
