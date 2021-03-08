# Installation

## Production

### Install from rubygems.org

```plaintext
$ gem install pass-station
```

Gem: [pass-station](https://rubygems.org/gems/pass-station)

### Install from BlackArch

From the repository:

```plaintext
# pacman -S pass-station
```

PKGBUILD: [pass-station](https://github.com/BlackArch/blackarch/blob/master/packages/pass-station/PKGBUILD)

### Install from Pentoo

From the repository:

```plaintext
# emerge TODO/pass-station
```

## Development

It's better to use [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://github.com/asdf-vm/asdf) to have latests version of ruby and to avoid trashing your system ruby.

### Install from rubygems.org

```plaintext
$ gem install --development pass-station
```

### Build from git

Just replace `x.x.x` with the gem version you see after `gem build`.

```plaintext
$ git clone https://github.com/sec-it/pass-station.git pass-station
$ cd pass-station
$ gem install bundler
$ bundler install
$ gem build pass-station.gemspec
$ gem install pass-station-x.x.x.gem
```

Note: if an automatic install is needed you can get the version with `$ gem build pass-station.gemspec | grep Version | cut -d' ' -f4`.

### Run without installing the gem

From local file:

```plaintext
$ irb -Ilib -rpass_station
```

Same for the CLI tool:

```plaintext
$ ruby -Ilib -rpass_station bin/pass-station
```

