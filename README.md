# php-switcher.sh

php-switcher is to switch Homebrew php.


## Installation

With [bpkg](https://github.com/bpkg/bpkg) do:

    $ bpkg install rochefort/php-switcher.sh

Then add the following to httpd.conf 
```
LoadModule php5_module    /usr/local/lib/php/libphp5.so
```

## Usage

    $ php-switcher php56


## Contributing

1. Fork it ( https://github.com/[my-github-username]/php-switcher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
