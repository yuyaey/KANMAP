# Capistrano::nodenv [![Gem Version](https://badge.fury.io/rb/capistrano-nodenv.png)](http://badge.fury.io/rb/capistrano-nodenv)

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'capistrano', '~> 3.1'
gem 'capistrano-nodenv', '~> 1.0'
```

And then execute:

    $ bundle --binstubs
    $ cap install

## Usage

```ruby
# Capfile

require 'capistrano/nodenv'

set :nodenv_type, :user # or :system, depends on your nodenv setup
set :nodenv_node, '0.10.3'
set :nodenv_prefix, "NODENV_ROOT=#{fetch(:nodenv_path)} NODENV_VERSION=#{fetch(:nodenv_node)} #{fetch(:nodenv_path)}/bin/nodenv exec"
set :nodenv_map_bins, %w{node npm}
set :nodenv_roles, :all # default value
```

If your nodenv is located in some custom path, you can use `nodenv_custom_path` to set it.

## Thanks

Thanks to [capistrano/rbenv constributors](https://github.com/capistrano/rbenv/graphs/contributors) becasue I just modified that gem to work with nodenv

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/guides/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

capistrano-nodenv is maintained by [platanus](http://platan.us).

## License

Guides is © 2014 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.

