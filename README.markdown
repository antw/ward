# Luggage

### What is it?

> The Luggage is a fictional object that appears as a character in several of
> the Discworld novels by Terry Pratchett. It is a large chest made of sapient
> pearwood. It can produce hundreds of little legs protruding from its
> underside and can move very fast if the need arises. It has been described
> as "half suitcase, half homicidal maniac"
>
> Its function is to act as both a luggage carrier and bodyguard for its
> owner, against whom no threatening motion should be made. The Luggage is
> fiercely defensive of its owner, and is generally homicidal in nature,
> killing or eating several people and monsters and destroying various ships,
> walls, doors, geographic features, and other obstacles throughout the
> series. Its mouth contains "lots of big square teeth, white as sycamore, and
> a pulsating tongue, red as mahogany." The inside area of The Luggage does
> not appear to be constrained by its external dimensions, and contains many
> conveniences: even when it has just devoured a monster, the next time it
> opens the owner will find his underwear, neatly pressed and smelling
> slightly of lavender.
>
> --- Wikipedia's description of "The Luggage"

### So... what _is_ it?

Object validation inspired by RSpec.

### What I hope to achieve

    class MyWonderfulObject
      include Luggage::Validation
      attr_accessor :name, :subdomain, :posts

      validates(:name).length.is(2..100)

      # or

      validates(:subdomain).has(2..50).characters

      # or

      validates(:subdomain) do |subdomain|
        subdomain.length.is(2..50)
        subdomain.format.with(/\A[a-z][a-z0-9\-]*[a-z0-9]\Z/)
      end

      # or

      validates do |object|
        object.subdomain.length.is(2..50)
        object.has.at_least(5).posts
        object.owner.name.is("Rincewind")
      end
    end

Note: None of this actually works at the moment. To describe Luggage as being in the early-stages of development would be to make a pretty extraordinary understatement.

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
