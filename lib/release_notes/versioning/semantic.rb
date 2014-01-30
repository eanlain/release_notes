module ReleaseNotes
  module Versioning
    module Semantic
      class << self
        
        def increment(version, type)
          if version.nil?
            ReleaseNotes.starting_version
          else
            parts = parse_version(version.gsub('.md', ''))

            if type.downcase == 'major' or type == 'M'
              parts = increment_major(parts)
            elsif type.downcase == 'minor' or type == 'm'
              parts = increment_minor(parts)
            else
              parts = increment_patch(parts)
            end
              
            new_version = parts.join('.')
            new_version
          end
        end
      
        protected
          def parse_version(version)
            version.split('-').first.split('.')
          end

          def increment_major(parts)
            parts[0] = (parts[0].to_i + 1).to_s
            parts[1] = '0'
            parts[2] = '0'
            parts
          end

          def increment_minor(parts)
            parts[1] = (parts[1].to_i + 1).to_s
            parts[2] = '0'
            parts
          end

          def increment_patch(parts)
            parts[2] = (parts[2].to_i + 1).to_s
            parts
          end
      end
    end
  end
end