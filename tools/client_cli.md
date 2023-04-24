_Clients_:    [**CLI**](client_cli.md) | [GUI](client_gui.md) | [Add-ons](client_addon.md) | [Website](client_web.md)

----

## CLI tool

### Usage

```shell
mypdnsrep token
    Set or delete your mypdns.org token

mypdnsrep category URL|Domain[| Comment]
    category is "API" cat value
    e.g.
      mypdnsrep redirector https://bitly.com/
      mypdnsrep Phishing https://signup-google.com/
      mypdnsrep porn www.porn.com "This is a porn site."

If you input only domain it will be treated as http://domain.
  mypdnsrep phishing www.google.com
  = mypdnsrep phishing http://www.google.com
```

Sit back and let the script do some working before it will appear
committed.


### Download

  - [**for Windows**: mypdnsrep.exe](https://mypdns.eu.org/dl/cli/mypdnsrep.exe)
  - [**for Linux**: mypdnsrep.linux](https://mypdns.eu.org/dl/cli/mypdnsrep.linux)
  - [**for Mac OS**: mypdnsrep.macos](https://mypdns.eu.org/dl/cli/mypdnsrep.app)
  - [Source code](https://mypdns.eu.org/dl/cli/source.js), The above source code so you can compile it yourself

```
Version: 1.0.3.6

What is changed from previous?

- sync encoding
```

#### Linux usage

```shell
sudo cp mypdnsrep.linux /usr/local/bin/mypdnsrep && \
    sudo chmod +x /usr/local/bin/mypdnsrep && \
    sudo chown root:root /usr/local/bin/mypdnsrep
```

```terminal
sudo wget -O /usr/local/bin/mypdnsrep https://mypdns.eu.org/dl/cli/mypdnsrep.linux && \
    sudo chmod +x /usr/local/bin/mypdnsrep && \
    sudo chown root:root /usr/local/bin/mypdnsrep
```

You might need to reload your `$PATH:` now, or just reopen your terminal.
