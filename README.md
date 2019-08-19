# rubocop_plus

rubocop_plus is a gem that wraps around the community [rubocop gem](https://github.com/bbatsov/rubocop).  It makes changes and enhancements to the base rubocop gem by altering configuration and code.  All configuration changes can be found in the `config` folder.

#### Disclaimer

rubocop_plus was built as a place to store **my preferred** rubocop configuration and enhancements, in a single location.  **There is absolutely no association with the base rubocop project.**  rubocop_plus was made public so it could be shared between multiple organizations that I support, and to serve as a reference gem to anyone who wants to do some similar.

## Version Policy

Releases are versioned using [semver 2.0.0](https://semver.org/spec/v2.0.0.html).

## Installation

You can install rubocop_plus manually by performing

    $ gem install rubocop_plus

You can also place rubocop_plus in your project's Gemfile

```ruby
gem 'rubocop_plus'
```

Remove rubocop from the project's Gemfile and Gemfile.lock.  rubocop_plus will install the version of rubocop that it wants to use.

Then run

    $ bundle

Initialize your project's rubocop configuration

    $ rubo --init

This will create a specially configured `.rubocop.yml` inside the project root.

**Note:** Keep in mind, if you place rubocop_plus in a projects Gemfile, it will **lock** your project to the version of rubocop_plus that gets written to the Gemfile.lock file.  If you're using a continuous integration platform, like Jenkins or Travis, this will likely restrict the CI tool to that same version - which is not always ideal.  Some people prefer to have the CI platform **tell** the project which version of rubocop_plus to use.  In that case, you should not put the rubocop_plus in the project's Gemfile.

## Usage

`rubocop_plus` provides a `rubo` command that you can  use run to invoke rubocop in a standard manner.  It will write all output to the `rubocop` folder inside the project.  You can run `rubo --help` to see a list of commands.  If rubocop_plus is included the project's Gemfile, rubo will execute the locked version.  Otherwise, it will execute the latest version on the system.

#### Total Violation Count

The `rubo` command will create a `rubocop/total-violations-count.txt file` as part of the output.  This file holds a single number that represents the total number of violations that were found by rubocop.  This file was created so continuous integration tools like Jenkins or Travis could be configured to fail builds that have "too many" violations.

#### Specifying the Correct Ruby

rubocop needs to know which version of ruby to use to have a basis for evaluating your application.  rubocop_plus does not perform any magic here, but we offer a recommendation on how to proceed:

1. Make sure your `.rubocop.yml` does not include the `TargetRubyVersion` key under `AllCops:`.  If it is present, rubocop will always use that value.
1. Create a `.ruby-version` file and define your ruby version inside this file.  The file should have a single value specifying the full ruby version (i.e 2.5.0).
1. Specify the `ruby` version in the Gemfile by adding `ruby File.read('.ruby-version', mode: 'rb').chomp` to the Gemfile.  This will avoid duplication by reading the value out of the `.ruby-version` file.

As of rubocop 0.52.1 (01/15/2018), rubocop does not look at the Gemfile to determine the ruby version.  Hopefully that will change in the future.  Until then, rubocop will pull the value out of the `.ruby-version` file and other services can read the value from `.ruby-version` or the `Gemfile`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The easiest way to test the gem locally is to `cd` into a ruby project that can serve as a test bed.  From the sample project's root folder, execute `rubo` by typing the relative (or full path) to the `rubo` command where you cloned the rubocop_plus project.  If your sample_app and rubocop_plus folder were in the same parent folder, your command would look like `../rubocop_plus/exe/rubo`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run rubocop_plus on itself, `cd` to the root of `rubocop_plus` and run `exe/rubo`. If you just run `rubo`, you'll be invoking the version of `rubo` that was installed by the latest installed version of the gem...not the version of `rubo` within the development folder of the gem.

## Contributing

Contributions are welcome, but please be aware that rubocop_plus was created to serve the projects and teams that I directly support.  Their needs and style preferences will always come first.  To contribute, create an issue on the [GitHub Issue board](https://github.com/roberts1000/rubocop_plus/issues) and wait for feedback.  Once the idea is approved, submit a Pull Request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
