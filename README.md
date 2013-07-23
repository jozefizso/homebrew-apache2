homebrew-apache2
----------------

[homebrew][h] + [Apache][a].

[h]: https://github.com/mxcl/homebrew
[a]: https://httpd.apache.org/

**Installation**

    brew tap homebrew/dupes
    brew tap jozefizso/homebrew-apache2

    brew install jozefizso/apache2/apache24

You can also install Apache 2.2:

    brew install jozefizso/apache2/apache22


**Caveats**

While it is possible to have both Apache 2.2 and Apache 2.4 installed
at the same time, it's not possible to have both linked at the same time.

If you want to switch between versions, you'll need to `brew unlink` currently linked version first.
