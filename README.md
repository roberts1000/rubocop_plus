# rubocop_plus

`rubocop_plus` is a Ruby gem that wraps around the community [rubocop](https://github.com/bbatsov/rubocop) gem. It makes changes and enhancements to the base `rubocop` gem by altering configuration and code. All configuration changes can be found in the `config` folder.

#### Disclaimer

`rubocop_plus` was built to store **my preferred** `rubocop` configuration and enhancements. **There is absolutely no association with the base rubocop project.** `rubocop_plus` was made public so it could be used by projects that I support, and to serve as a reference gem to anyone who wants to do something similar.

## Version Policy

Releases are versioned using [semver 2.0.0](https://semver.org/spec/v2.0.0.html).

Ruby versions that reach EOL will be removed without a major version bump.

## Supported Ruby Versions

Ruby 2.6.0+ is supported.

## Installation

Install `rubocop_plus` manually by executing:

    $ gem install rubocop_plus

You can also add `rubocop_plus` to the `:development` group of your project's `Gemfile`:

```ruby
gem 'rubocop_plus', group: :development
```

If `rubocop` is listed in the `Gemfile`, remove it. `rubocop_plus` will install the version of `rubocop` that it needs.

(**Note:** Keep in mind, if you place `rubocop_plus` in a projects Gemfile, it will **lock** your project to the version of `rubocop_plus` that gets written to the Gemfile.lock file. If you're using a CI tool like Jenkins, this will likely make the CI tool use that same version - which is not always ideal. Some people prefer to have the CI platform **tell** the project which version of `rubocop_plus` to use. If this is your goal, do not put the `rubocop_plus` in the project's Gemfile.)

Next, bundle the app:

    $ bundle

Initialize your project's `rubocop` configuration

    $ rubo --init

This will create a `.rubocop.yml` inside the project root. By default, this file has configuration that tells `rubocop` to look in the `rubocop_plus` gem for custom RuboCop configuration. You can add additional configuration to this file if you would like to make other changes to RuboCop.

## Usage

`rubocop_plus` provides a `rubo` command that you can use run to invoke `rubocop` in a standard manner. It will write all output to the `rubocop` folder inside the project. You can run `rubo --help` to see a list of commands. If `rubocop_plus` is included the project's Gemfile, rubo will execute the locked version. Otherwise, it will execute the latest version on the system.

#### Total Violation Count

The `rubo` command will create a `rubocop/total-violations-count.txt file` as part of the output. This file holds a single number that represents the total number of violations that were found by `rubocop`. This file was created so continuous integration tools like Jenkins or Travis could be configured to fail builds that have "too many" violations.

## Development

### Setup

Checkout the repo, `cd` into the project and run:

    $ bin/setup

### Run the Test Suite

Run the test suite:

    $ bin/start_rspec

### Start a Development Console

Start an interactive prompt that will allow you to experiment(choose one):

```bash
$ bin/console  # for Pry
$ rake console # for IRB
```

### Workflow Advice

The easiest way to develop with the gem locally is to `cd` into another ruby project that can serve as a test bed. From the sample project's root folder, execute `../path/to/rubocop_plus/exe/rubo`.

### Release a New Version

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`. This will create a git tag for the version, push git commits and tags, and push the gem to [rubygems.org](https://rubygems.org).

### Run rubocop_plus on Itself

To run `rubocop_plus` on itself, `cd` to the root of `rubocop_plus` and run `exe/rubo`. If you just run `rubo`, you will invoke the installed version of `rubo` and not the version of `rubo` within the cloned project folder.

## Contributing

Contributions are welcome, but please be aware that `rubocop_plus` was created to serve the projects and teams that I directly support. Their needs and style preferences will always come first. To contribute, create an issue on the [GitHub Issue board](https://github.com/roberts1000/rubocop_plus/issues) and wait for feedback. Once the idea is approved, submit a Pull Request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
