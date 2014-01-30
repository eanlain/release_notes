require 'release_notes/versioning/semantic'

module ReleaseNotes
  module Versioning
    class << self
      def current_version_number(dirname)
        last_timestamp = version_lookup_at(dirname).collect do |file|
          File.basename(file).split("_").first.to_i
        end.max.to_i

        last_version = Dir.glob("#{dirname}/#{last_timestamp}_*").to_s.split('/').last
        last_version = last_version.gsub(last_version[0..14], '')[0..-3].gsub('_', '.')

        if last_version.empty?
          return nil
        else
          return last_version
        end        
      end

      def version_lookup_at(dirname)
        Dir.glob("#{dirname}/[0-9]*_*")
      end
    end
  end
end