_Clients_:    [CLI](client_cli.md) | [**GUI**](client_gui.md) | [Add-ons](client_addon.md) | [Website](client_web.md)

----

## GUI tool (Windows)

### Usage
  - How to use
    - Extract the ZIP file to some folder and run `mypdns.exe`.
  - Uninstall/Remove
    - Just simply delete those files.

### Config
You can configure this software by editing `mypdns.conf` file.
_Close mypdns.exe before editing this file!_
The config file is like this:

```
50 (the last window position)
50 (the last window position)
xxxxxxx (your token)
#noTop
#useTor
```

- `#noTop`
  - By default the window always stay on top.
  - You can disable this by changing this line to `noTop` (just remove `#`)
- `#useTor`
  - By default the software connect directly (just like above API examples)
  - If you have Tor listening on `127.0.0.1:9050` you can enable this by
    changing it to `useTor`.

### Download

  - [**for Windows**: gui.zip](https://mypdns.eu.org/dl/gui/gui.zip)
  - [Source code](https://mypdns.eu.org/dl/gui/source.sp), The above source code so you can compile it yourself

```
Version: 1.0.1.4
What is changed from previous?

- sync encoding
```
