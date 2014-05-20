# ReleaseNotes

An easy way to incorporate and manage release notes.

## Installation

Add this line to your application's Gemfile:

    gem 'release_notes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install release_notes

## Getting Started

If you're looking to use ReleaseNotes with Rails you will need to run the install generator:

    $ rails generate release_notes:install

The generator will install a ReleaseNotes initializer containing various configuration options and a ReleaseNotes controller decorator. When you are done, you are ready to add a ReleaseNote model to using the following generator:

    $ rails generate release_notes ReleaseNote

This will generate a model named `ReleaseNote` in your Rails project and will add a route in your `config/routes.rb` file at `/release_notes`. You can choose to use a different model name, but after doing so you must update `config.release_note_model` in the release_notes initializer with the name of the model you generated.

Be sure to migrate your database.

    $ rake db:migrate

## Usage

### Generate a new release note template

To create a new release note run the following:

    $ release_notes new

A new release note markdown file will be generated and saved to the `release_notes` folder. Open the file in your favorite editor and fill out the relevant sections to your heart's content.

### Generate a new release note from the console

To add release notes bullets through the console try the following:

    $ release_notes new -m

This will also generate a release note markdown file, but all the bullets entered in the console will appear in the relevant sections in the markdown file.

### Update ReleaseNote model with new release notes

After finalizing your release note markdown file be sure to update your ReleaseNote model by running:

    $ release_notes update

If you ever want to update a previous release note and/or want to rebuild your ReleaseNotes model and README you can run the following:

    $ release_notes update -r

### Getting Help

To get additional help on release_notes commands or to see all available options just run:

    $ release_notes --help [command]

### View release notes in your application

To view all of your release notes just visit `http://yourapp/release_notes` (or whatever route is mounted in your `routes.rb` file) in your application. To view a specific version just visit `http://yourapp/release_notes/:version` where `:version` is the release notes version that you are looking to view using underscores instead of periods (i.e. `0_1_0`).

## Contributing

1. Fork it ( http://github.com/eanlain/release_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
