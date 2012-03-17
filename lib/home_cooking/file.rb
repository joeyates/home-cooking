require 'digest/sha1'
require 'pp'

module HomeCooking

  class File

    SHA1_STAMP  = 'HOME-COOKING-SHA1'
    STAMP_MATCH = Regexp.new( "^# #{ SHA1_STAMP }" )

    def initialize( path_name )
      @path_name = path_name
      @lines     = ::File.open( @path_name ).map { | l | l }
    end

    def modified?
      i           = stamp_line
      return true if i.nil?

      current_sha = @lines[ i ][ /^# #{ SHA1_STAMP } (.*)/, 1]
      clean     = @lines.select { | line | line !~ STAMP_MATCH }
      clean_sha = sha( clean.join )

      current_sha != clean_sha
    end


    def stamped?
      ! stamp_line.nil?
    end

    def sha( text )
      Digest::SHA1.hexdigest( text )
    end

    def stamp!
      puts "stamping #{ @path_name }"
      @lines.reject! { | line | line =~ STAMP_MATCH } 
      # Ensure there's a final newline
      if @lines[ -1 ] !~ /\n$/
        @lines[ -1 ] += "\n"
      end

      text = @lines.join
      sha1 = sha( text )
      text += "# #{ SHA1_STAMP } #{ sha1 }\n"

      ::File.open( @path_name, 'w' ) { | f | f.write text }
    end

    private

    def stamp_line
      @lines.find_index { | line | line =~ STAMP_MATCH }
    end

  end

end

