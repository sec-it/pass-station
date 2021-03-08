# Usage

## CLI

```plaintext
$ pass-station --help
Pass Station

Usage:
  pass-station list [--sort <col> --output <format>] [--debug]
  pass-station search <term> [--field <col> --sort <col> --sensitive --output <format>] [--no-color --debug]
  pass-station update ([--force] <path> | --check) [--debug]
  pass-station -h | --help
  pass-station --version

List options: list all default credentials

Output options: can be used with list and search commands
  -o <format>, --output <format>  Output format: JSON, CSV, YAML, table, pretty-table [default: pretty-table]
  -s <col>, --sort <col>          Sort by column: productvendor | username | password [default: productvendor]

Search options:
  --field <col>   Search in column: productvendor | username | password | all [default: productvendor]
  --sensitive     Sarch is case sensitive (case insensitive by default)

Update options: update the password database (replace Pass Station DB with upstream DB, use with care)
  -f, --force   Bypass hash checking
  -c, --check   Check for possible update

Other options:
  --no-color  Disable colorized output
  --debug     Display arguments
  -h, --help  Show this screen
  --version   Show version
```

## Library

```ruby
require 'pass_station'

ps = PassStation::DB.new
ps.parse
res = ps.search('weblogic',:productvendor)

# iterate
res.each do |item|
  product, username, password = item.to_h.values
end

# or get specific attribute of an entry
password = item[42][:password]
```

See the [library documentation](/yard/)

## Console

Launch `irb` with the library loaded.

```plaintext
$ pass-station_console
irb(main):001:0>
```
