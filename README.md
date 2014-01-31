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

    rails generate release_notes:install

The generator will install an initializer containing ReleaseNote's various configuration options. When you are done, you are ready to add a ReleaseNote model to using the following generator:

    rails generate release_notes ReleaseNote

This will generate a model named `ReleaseNote` in your Rails project. You can choose to use a different model name, but after doing so you must update `config.release_note_model` in the `config/initializers/release_notes.rb` file with the name of the model you generated.

## Usage

To create a new release note run the following:

    $ release_notes new

A new release note markdown file will be generated in the `release_notes` folder. Open the file in your favorite editor and fill out the relevant sections to your heart's content.

To add release notes bullets through the console try the following:

    $ release_notes new -m

This will also generate a release note markdown file, but all the bullets entered in the console will appear in the relevant sections in the markdown file.

## Contributing

1. Fork it ( http://github.com/eanlain/release_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
