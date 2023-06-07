_Clients_:    [CLI](client_cli.md) | [GUI](client_gui.md) | [Add-ons](client_addon.md) | [Website](client_web.md) | [**Mail**](client_mail.md)

----

# Mail

You can report domains or create new support issue via email.

- `mypdns_report@riseup.net` for _reporting_ domains (details below)
- `mypdns_support@riseup.net` for _creating new support issue_


----
----

# How to report domains by email

- Simply send an email to `mypdns_report@riseup.net` with understandable comment.
- Subject does not matter (empty is OK)
- One `domain`/`FQDN`/`URL` per line.
  - Other format will be read as comment.


> Good Example

- Those 4 domains will be reported as ~News with a comment "`those are news sites about airplane. or should I write aeroplane??`"

```
alpha.com
www.beta.net
blog.charlie.com
https://airlines.charlie.com/

those are news sites about airplane.
or should I write aeroplane??
```


> Bad Example

- No comment = no category
```
alpha.com
www.beta.net
blog.charlie.com
```

- The line is not domain, FQDN, or URL.
```
abc.net.au,news,USA

this is news okay?
```

- The comment does not explain the category
  - The issue will be created to Support board instead
```
russian.cat

I like Russian Blue. How about you?
```
