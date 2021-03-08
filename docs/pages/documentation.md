# Documentation 

## CLI doc

See [Usage](pages/usage.md?id=cli).

### Server locally

```plaintext
$ npm i docsify-cli -g
$ docsify serve docs
```

## Library doc

The output directory of the library documentation will be `docs/yard`.

You can consult it online [here](https://sec-it.github.io/pass-station/yard/).

⚠ Private and protected methods are not displayed properly: https://github.com/lsegal/yard/issues/1372

### Building locally: for library users

For developers who only want to use the library.

```plaintext
$ bundle exec yard doc
```

### Building locally: for project developer

For developers who want to participate to development of the project.

```plaintext
$ bundle exec yard doc --yardopts .yardopts-dev
```
