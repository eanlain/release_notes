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

### Optional

#### Broadcasts

To add the ability to display broadcasts of new releases (or any other messages) run the following:

    $ rails generate release_notes:broadcasts Broadcast

This will generate a model named `Broadcast` in your Rails project. You can choose to use a different model name, but you must edit the release_notes initializer file with the updated Broadcast name.

Migrate your database.

    $ rake db:migrate

Then add one of the following render tags to whichever view you'd like to display the broadcast message in.

    <%= render 'release_notes/broadcasts/link_back' %>

OR...

    <%= render 'release_notes/broadcasts/bare' %>

#### Views

While not necessary, you may want to copy over the ReleaseNotes views to your app to customize:

    $ rails generate release_notes:views

If you do decide to customize the ReleaseNotes views and want to use your own layout you should probably **(1)** edit the layout declaration in `app/decorators/controllers/release_notes/release_notes_controller_decorator.rb` and **(2)** add one of the following stylesheet_link_tag snippets to your view:

    <%= stylesheet_link_tag "release_notes/application", media: "all" %>

Will load Bootstrap 3 and a [Github Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) style.

    <%= stylesheet_link_tag "release_notes/github", media: "all" %>

Will load just the [Github Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) style.


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

If you ever want to update a particular release note you can run the following, where `VERSION` is the specific release note version that you want to update.

    $ release_notes update -v=VERSION

This will only update the release note matching the version number specified.

### View release notes in your application

To view all of your release notes just visit `http://yourapp/release_notes` (or whatever route is mounted in your `routes.rb` file) in your application. To view a specific version just visit `http://yourapp/release_notes/:version` where `:version` is the release notes version that you are looking to view using underscores instead of periods (i.e. `0_1_0`).

### Create a new Broadcast

To create a new Broadcast run:

    $ release_notes broadcast new

This will generate a broadcast markdown file which you can edit.
**Note:** You *can* use HTML within the markdown file.

### Update Broadcast

After finalizing your broadcast markdown file be sure to update your Broadcast model by running:

    $ release_notes broadcast update

If you ever want to update a particular broadcast you can run the following:

    $ release_notes broadcast update -v=VERSION

### Set a Broadcast

You can set a specific broadcast to set as the "latest" broadcast (the default shown by using the broadcast partials) by running the following:

    $ release_notes broadcast set_version VERSION

The "latest" version will be set to the `VERSION` specified.

## Contributing

1. Fork it ( http://github.com/eanlain/release_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
