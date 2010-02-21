# From Sequel, with modifications to support RSpec.
#
# Copyright (c) 2007-2008 Sharon Rosner
# Copyright (c) 2008-2009 Jeremy Evans
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Luggage
  module Support

    if RUBY_VERSION < '1.9.0'
      # If on Ruby 1.8, create a Luggage::BasicObject class that is similar to
      # the Ruby 1.9 BasicObject class. This is used as the basis for the DSL
      # classes.
      class BasicObject
        (instance_methods - %w( __id__ __send__ instance_eval == equal?
              should should_not )).each do |method|
          undef_method(method.to_sym)
        end
      end
    else
      class BasicObject
        # Lookup missing constants in ::Object
        def self.const_missing(name)
          ::Object.const_get(name)
        end
      end
    end

  end # Support
end # Luggage
