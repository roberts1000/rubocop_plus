# rubocop_plus

`rubocop_plus` is a Ruby gem that wraps around the [rubocop](https://github.com/bbatsov/rubocop) gem. It makes changes and enhancements to `rubocop` by altering configuration and code. All configuration changes can be found in the `config` folder.

**Disclaimer:** rubocop_plus was built to store **my preferred** rubocop configuration and enhancements. **There is no association with the base rubocop project.** rubocop_plus was made public so it could be used by projects that I support, and to serve as a reference gem to anyone who wants to do something similar.

## Versioning Strategy

1. Releases are versioned using [semver 2.0.0](https://semver.org/spec/v2.0.0.html).
1. Ruby versions that reach EOL are removed in a major or minor release.

## Supported Ruby Versions

Ruby 2.7.0+ is supported.

## Installation

Install rubocop_plus manually by executing:

    $ gem install rubocop_plus

You can also add rubocop_plus to the `:development` group of your project's `Gemfile`:

```ruby
group :development do
  gem 'rubocop_plus', require: false
end
```

If you add rubocop_plus to your `Gemfile`, it is recommended that you use `require: false`. There's no need to load rubocop_plus files when your project runs.

**Keep in mind**, if you place rubocop_plus in a project's `Gemfile`, it will **lock** your project to the version of rubocop_plus that gets written to the `Gemfile.lock`. If you're using a CI tool like Jenkins, this will likely make the CI tool use that same version - which is not always the desired outcome.

Next, remove the `rubocop` gem if it's listed in the `Gemfile`. rubocop_plus will install the version of rubocop that it needs.

Bundle the app:

    $ bundle

Initialize your project's rubocop configuration:

    $ rubo --init

This will create a `.rubocop.yml` inside the project root. By default, this file has configuration that tells rubocop to look in the rubocop_plus gem for custom RuboCop configuration. You can add additional configuration to this file if you would like to make other changes to RuboCop.

## Usage

rubocop_plus provides a `rubo` command that you can use run to invoke rubocop in a standard manner. It will write all output to the `rubocop/` folder inside the project. You can run `rubo --help` to see a list of commands. If rubocop_plus is included the project's Gemfile, rubo will execute the locked version. Otherwise, it will execute the latest version on the system.

#### Total Violation Count

The `rubo` command creates a `rubocop/total-violations-count.txt file` as part of the output. This file holds a single number that represents the total number of violations that were found by rubocop. This file was created so continuous integration tools like Jenkins could be configured to fail builds that have "too many" violations.

## Development

### Setup

Checkout the repo, then `cd` into the project and run:

    $ bin/setup

### Run the Test Suite

Run the test suite:

    $ bin/start_rspec

### Start a Development Console

Start an interactive prompt that will allow you to experiment (choose either):

```bash
$ bin/console  # for Pry
$ rake console # for IRB
```

### Workflow Advice

The easiest way to develop with the gem locally is to `cd` into another ruby project that can serve as a test bed. From the sample project's root folder, execute `/path/to/rubocop_plus/exe/rubo` to execute the development version of rubocop_plus.

### Release a New Version

To release a new version, update the version number in `version.rb`, and then run `rake release`. This will create a git tag for the version, push git commits and tags, and push the gem to [rubygems.org](https://rubygems.org).

### Run rubocop_plus on Itself

To run rubocop_plus on itself, `cd` to the root of the `rubocop_plus` development folder and run `exe/rubo`. If you just run `rubo`, you will invoke the `rubo` for the latest **installed** rubocop_plus gem and not the version of `rubo` within the development folder.

## Contributing

Contributions are welcome, but please be aware that rubocop_plus was created to serve the projects and teams that I directly support. Their needs and style preferences will come first. To contribute, create an issue on the [GitHub Issue board](https://github.com/roberts1000/rubocop_plus/issues) and wait for feedback. Once the idea is approved, submit a Pull Request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
