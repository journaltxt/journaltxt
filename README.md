# journaltxt - reads Journal.TXT and writes out (auto-builds) a blog (w/ Jekyll posts etc.)

* home  :: [github.com/journaltxt/journaltxt](https://github.com/journaltxt/journaltxt)
* bugs  :: [github.com/journaltxt/journaltxt/issues](https://github.com/journaltxt/journaltxt/issues)
* gem   :: [rubygems.org/gems/journaltxt](https://rubygems.org/gems/journaltxt)
* rdoc  :: [rubydoc.info/gems/journaltxt](http://rubydoc.info/gems/journaltxt)
* forum :: [groups.google.com/group/wwwmake](http://groups.google.com/group/wwwmake)


## Usage

Use the single-file [Journal.TXT format](https://journaltxt.github.io)
to write your blog posts / journal entries.
Example:

```
---
year:  2017
month: July
day:   Mon 17
---

Jumping on tram #1 in front of the Staatsoper (state opera house).
Circling the Ringstrasse (grand boulevard vienna ring road)
for a great tour with a public transport ticket.
Passing the Hofburg (imperial palace), Parlament,
Burggarten (imperial court's garden),
Rathaus (city council), Burgtheater (imperial court's theatre),
Vienna University, and more. [...]

---
day:   Tue 18
---

Visiting the imperial palace Schönbrunn - the former summer residence
of the Habsburg family.
Taking an inside tour of the 1 441-room baroque palace.
Enjoying the Neptune Fountain and sculptures in the public garden. [...]

---
day:   Wed 19
---

Visiting the Sigmund Freud Museum in Bergstrasse 9. Too much culture -
need a beer therapy soon.
Passing through the Palais Lichtenstein to the
Beaver Brewing Co. (Liechtensteinstraße 69). [...]
```

(Source: [samples/Vienna.txt](https://github.com/journaltxt/journaltxt.github.io/blob/master/samples/Vienna.txt))


Try the `journaltxt` or `jo` (shortened alternate) command line tool e.g.:

```
$ journaltxt --help

Usage: journaltxt [OPTS] [JOURNAL.TXT FILES...]
    -v, --[no-]verbose               Show debug messages
    -o, --output=PATH                Output path (default: .)
    -n, --name=NAME                  Journal name (default: Journal)
        --[no-]date                  Add date to page title (default: true)
    -h, --help                       Prints this help
```

For example, to auto-build all posts for a static Jekyll website / blog
in the `YYYY-MM-DD-title.md` format from a single-file in the Journal.TXT format
e.g. [Vienna.txt](https://github.com/journaltxt/journaltxt.github.io/blob/master/samples/Vienna.txt) use:

```
$ journaltxt --output=_posts Vienna.txt
     -or-
$ journaltxt -o _posts Vienna.txt
     -or-
$ jo -o _posts Vienna.txt
```

resulting in:

```
Writing entry 1/3 >Vienna - Day 1< to ./_posts/2017-07-17-vienna.md...
Writing entry 2/3 >Vienna - Day 2< to ./_posts/2017-07-18-vienna.md...
Writing entry 3/3 >Vienna - Day 3< to ./_posts/2017-07-19-vienna.md...
```

That's it.
**See the live auto-built [Vienna.TXT Blog »](https://journaltxt.github.io/blog)**


Tip: If you run the Journal.TXT command line tool in
the folder with a single-file in the Journal.TXT format named `journal.txt`
than you can use:

```
$ journaltxt
    -or-
$ jo
```

Happy writing. Happy publishing.



## Bonus: Add Your Perfect Day!

Berlin.TXT, Munich.TXT, Salzburg.TXT, Paris.TXT, London.TXT, Rome.TXT, New York.TXT, Austin.TXT, Tornoto.TXT, Calgary.TXT,
Melbourne.TXT, Sydney.TXT, ...   - Anyone?
Write your perfect day(s) in a single-text file with Journal.TXT.



## Install

Just install the gem:

```
$ gem install journaltxt
```


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `journaltxt` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [wwwmake Forum/Mailing List](http://groups.google.com/group/wwwmake).
Thanks!
