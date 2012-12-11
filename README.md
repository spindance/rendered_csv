# RenderedCsv

RenderedCsv provides a `render_csv` method to your Rails 3.0+ controllers.

## Installation

Add this line to your application's Gemfile:

    gem 'rendered_csv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rendered_csv

## Usage

In your controllers, simply call `render_csv` instead of `render`.  This will setup the appropriate headers and render your CSV file.

`render_csv` has two optional parameters, `filename` and `template`.  If not specified, `filename` defaults to the name of the current action.

This example would respond with a file named `widgets.csv`, rendering the `index` template in the process:

    class WidgetsController < ApplicationController
      def index
        @widgets = Widget.all
        respond_to do |format|
          format.csv do
            render_csv('widgets')
          end
        end
      end
    end

You could render a different template: `render_csv('widgets', 'other_index')`

Or you could just use the defaults to get `index.csv` from the `index` template: `render_csv`

## Acknowledgements

The meat of this gem was taken from [Clinton R. Nixon's](http://stackoverflow.com/users/6262/clinton-r-nixon) answer to this [StackOverflow question](http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file).  I just wanted to stop copy-pasting the code from project to project.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
