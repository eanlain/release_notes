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

After installing ReleaseNotes you need to run the install generator:

    $ rails generate release_notes:install

The generator will install an initializer containing ReleaseNotes various configuration options. When you are done, you are ready to add a ReleaseNote model to using the following generator:

    $ rails generate release_notes ReleaseNote

This will generate a model named `ReleaseNote` in your Rails project. You can choose to use a different model name, but after doing so you must update `config.release_note_model` in the `config/initializers/release_notes.rb` file with the name of the model you generated.

Be sure to migrate your database.

    $ rake db:migrate


### Optional

#### Broadcasts

To add the Broadcasts module...

    $ rails generate release_notes:broadcasts Broadcast

This will generate a model named `Broadcast` in your Rails project. As mentioned before, you can choose to use a different model name, but remember to edit the `config/initializers/release_notes.rb` file with the name.

After generating the Broadcast model you should generate a migration to add the last_visit field to your User model.

    $ rails generate release_notes:last_visit User

Migrate your database.

    $ rake db:migrate


#### Views

While not necessary, you may want to copy over the ReleaseNotes views to your app to customize:

    $ rails generate release_notes:views

## Usage

### Generate a new release note template

To create a new release note run the following:

    $ release_notes new

A new release note markdown file will be generated in the `release_notes` folder. Open the file in your favorite editor and fill out the relevant sections to your heart's content.

### Generate a new release note from the console

To add release notes bullets through the console try the following:

    $ release_notes new -m

This will also generate a release note markdown file, but all the bullets entered in the console will appear in the relevant sections in the markdown file.

### Update ReleaseNote model with new release notes

After finalizing your release note markdown file be sure to update your ReleaseNote model by running:

    $ release_notes update

If you ever want to reset your model - maybe you've gone back and edited a previous release note - you can rebuild the ReleaseNote model by running `release_notes update -r` appending the `-r` option. 

### View release notes in your application

To view all of your release notes just visit `http://yourapp/release_notes` (or whatever route is mounted in your `routes.rb` file) in your application. To view a specific version just visit `http://yourapp/release_notes/:version` where `:version` is the release notes version that you are looking to view using underscores instead of periods (i.e. `0_1_0`).

## Contributing

1. Fork it ( http://github.com/eanlain/release_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
