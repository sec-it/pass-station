# Publishing

## On Rubygems.org

```plaintext
$ git tag -a vx.x.x
$ git push --follow-tags
$ gem push pass-station-x.x.x.gem
```

See https://guides.rubygems.org/publishing/.

On new release don't forget to rebuild the library documentation:

```plaintext
$ bundle exec yard doc
```

An to be sure all tests pass!

```plaintext
$ rake
```

## On BlackArch

BA process

On new release don't forget to rebuild the library documentation:

```plaintext
$ bundle exec yard doc
```

An to be sure all tests pass!

```plaintext
$ rake
```
