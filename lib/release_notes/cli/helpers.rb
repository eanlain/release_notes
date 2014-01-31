module ReleaseNotes
  class CLI < Thor
    class Helpers
      class << self
        include Thor::Shell

        def setup_message_obj
          message = {}
          message['overview'] = ""
          message['additions'] = []
          message['changes'] = []
          message['improvements'] = []
          message['removals'] = []
          message['fixes'] = []
          message['bugs'] = []
          message['upcoming'] = []
          message
        end

        def interactive_bullets(message)
          say "Enter in the letter type of bullet followed by the bullet's text (i.e. 'a: This is a simple addition bullet')", :yellow
          say "Bullet types are as follows => (a)dditions, (c)hanges, (i)mprovements, (r)emovals, (f)ixes, (b)ugs/Known Issues, (u)pcoming", :yellow
          say "When you are finished type 'done' to finish.", :cyan
          
          loop do
            input = ask('a/c/i/r/f/b/u: Bullet', :green)

            if input == 'done' or input == "'done'"
              break
            elsif input == 'cancel' or input == "'cancel'"
              return false          
            elsif input[0..2] == 'a: '
              message['additions'].push input[3..input.length]
              say "Addition bullet added."
            elsif input[0..2] == 'c: '
              message['changes'].push input[3..input.length]
              say "Changes bullet added."
            elsif input[0..2] == 'i: '
              message['improvements'].push input[3..input.length]
              say "Improvements bullet added."
            elsif input[0..2] == 'r: '
              message['removals'].push input[3..input.length]
              say "Removals bullet added."
            elsif input[0..2] == 'f: '
              message['fixes'].push input[3..input.length]
              say "Fixes bullet added."
            elsif input[0..2] == 'b: '
              message['bugs'].push input[3..input.length]
              say "Bugs/Known Issues bullet added."
            elsif input[0..2] == 'u: '
              message['upcoming'].push input[3..input.length]
              say "Upcoming bullet added."
            else
              say "Invalid format. Please try that last one again...", :red
            end
          end

          message['overview'] = ask "Please give a one (or two) sentence overview of this release... or just be unhelpful and press ENTER.", :yellow
          message
        end
      end
    end
  end
end