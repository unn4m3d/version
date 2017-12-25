# version

Small tool to fetch your shard version from shard.yml and not to write it by hand

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  version:
    github: unn4m3d/version
```

## Usage

```crystal
require "version"

module MyShard
  VERSION = Version.fetch
end
```

## Contributing

1. Fork it ( https://github.com/unn4m3d/version/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [unn4m3d](https://github.com/unn4m3d) - creator, maintainer
