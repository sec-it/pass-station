# Quick start

## Quick install

```plaintext
$ gem install pass-station
```

See [Installation](/pages/install)

## Default usage: CLI

```plaintext
$ pass-station search Weblogic
+----------------+----------+------------+
| productvendor  | username | password   |
+----------------+----------+------------+
| weblogic       | system   | weblogic   |
| Weblogic (web) | EXAMPLES | EXAMPLES   |
| Weblogic (web) | monitor  | password   |
| Weblogic (web) | operator | password   |
| Weblogic (web) | operator | weblogic   |
| Weblogic (web) | PUBLIC   | PUBLIC     |
| Weblogic (web) | system   | manager    |
| Weblogic (web) | system   | Passw0rd   |
| Weblogic (web) | system   | password   |
| Weblogic (web) | system   | welcome(1) |
| Weblogic (web) | weblogic | weblogic   |
| Weblogic (web) | WEBLOGIC | WEBLOGIC   |
| Weblogic (web) | weblogic | weblogic1  |
| Weblogic (web) | weblogic | welcome(1) |
+----------------+----------+------------+
```

See [Usage](/pages/usage)

## Default usage: library

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

See [Usage](/pages/usage)
