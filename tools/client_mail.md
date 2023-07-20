_Clients_:    [CLI](client_cli.md) | [GUI](client_gui.md) | [Add-ons](client_addon.md) | [Website](client_web.md) | [**Mail**](client_mail.md)

----

# Mail

You can report domains or create new support issue via email.

- `report@mypdns.eu.org` for _reporting_ domains (details below)
- `support@ypdns.eu.org` for _creating new support issue_

Some info:
- You will not receive any replies.
- Emails are deleted instantly after process (means we do not collect your address)
- To protect you from spam, the first half of email address will be masked.
  - `yourname@gmail.com` will become `[scrubbed]@gmail.com`


----
----

# How to report domains by email

- Simply send an email to above reporter address with understandable comment.
- Subject does not matter (empty is OK)
- One `domain`/`FQDN`/`URL` per line.
  - Other format will be read as comment.


> Good Example

- Those 4 domains will be reported as ~News with a comment "`those are news sites about airplane or aeroplane`"

```
those are news sites about airplane

alpha.com
www.beta.net
blog.charlie.com
https://airlines.delta.com/

or aeroplane
```


> Bad Example

- No comment
  - Unable to detect category
```
alpha.com
www.beta.net
blog.charlie.com
```

- `abc.net.au` will not be reported because of wrong format (not domain, fqdn or URL)
  - The final comment will be "`abc.net.au,news,USA this is news okay?`"
```
xyz.net.au
abc.net.au,news,USA
def.net.au

this is news okay?
```

- The comment does not have the category
  - The entire issue will be created to Support board instead
```
russian.cat
russian.blue

I like Russian Blue. How about you?
```

- You cannot mix categories
  - Only the first category will be considered. In below example, `thepiratebay.org` will be reported as ~News
```
here is some news
alpha.com
www.beta.net
blog.charlie.com

and a torrent
thepiratebay.org
```
