# Ward

_Ward is not ready for production use just yet. 0.1 should be considered a preview release only._

## What Is It?

Object validation inspired by RSpec. As it turns out, Ward looks very little like RSpec, but that's where the inspiration came from nonetheless.

The aim is to provide an expressive DSL which allows you to compose validations without the need to create special validation methods.

    class Person
      include Ward::Validation

      validate do |person|
        person.subdomain.length.is(2..50)
        person.has.at_least(5).posts
        person.owner.name.is("Michael Scarn")
      end
    end

Note: The syntax described above isn't currently supported, though you can achieve a very similar end result with 0.1:

    class Person
      cattr_accessor :validators

      # ...
    end

    Person.validators = Ward::ValidationSet.build do |person|
      person.subdomain.length.is(2..50)
      person.has.at_least(5).posts
      person.owner.name.is("Michael Scarn")
    end

    Person.validators.valid?(Person.new)
    # => false

    Person.validators.validate(Person.new)
    # => Ward::Support::Result

### Current Status & Roadmap

**Planned for 0.2:**

* Add the Ward::Validation module allowing for more conventional validation
  (defining the validations _on_ the object to be validated, as is the case
  with ActiveRecord and dm-validations).

* Documentation is severely lacking, and will be improved. In the
  meantime, Ward makes extensive use of Cucumber features (/features) where
  you will find many examples of how to use the library in your own
  applications.

* Ward error messages are currently in English only, but full i18n support is
  planned.

**Planned for 0.3:**

* Compatibility modules will be added to support at least ActiveRecord and
  DataMapper; and perhaps Sequel and other ORMs after that, depending on
  demand.

**Later:**

* The DSL is subject to change prior to 1.0.

### Compatibility

Ward specs are run against:

  * Ruby (MRI) 1.8.6 p399,
  * Ruby (MRI) 1.8.7 p249,
  * Ruby (YARV) 1.9.1 p378,
  * JRuby 1.4.0,
  * Rubinius RC3.

Ward depends on ActiveSupport 3.0 to provide support for inflections in error messages, and to add Ruby 1.9-style String interpolation. However, only the bare minimum is included from ActiveSupport in order to minimise the impact on your runtime environment (see `lib/ward.rb` for specifics).

### Note on Patches/Pull Requests

* Fork the project, taking care not to get any in your eyes.

* Make your feature addition or bug fix.

* Add tests for it. This is especially important not only because it helps
  ensure that I don't unintentionally break it in a future version, but also
  since it appeases Phyllis --- the goddess of Cucumbers --- who has been
  known to rain showers of fresh vegetables on those who don't write tests.

* Commit, but do not mess with the Rakefile, VERSION, or history. If you want
  to have your own version, that is fine, but bump version in a commit by
  itself so that I can ignore it when I pull.

* Send me a pull request. Bonus points for topic branches. But we all know
  everything is made up and the points don't matter.

### Copyright

Copyright (c) 2010 Anthony Williams, MIT Licensed.
