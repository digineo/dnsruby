module Dnsruby
  class RR
    #Class for TLSA records.
    #RFC 6698 Section 2
    class TLSA < RR
      ClassHash[[TypeValue = Types::TLSA, ClassValue = Classes::IN]] = self #:nodoc: all
      
      attr_accessor :usage, :selector, :matching_type, :data
      
      def from_data(data)
        @usage, @selector, @matching_type, @data = data
      end
      
      def from_string(string)
        if (string && string =~ /^(\d) (\d) (\d) ([a-z0-9]+)$/)
          @usage         = $1.to_i
          @selector      = $2.to_i
          @matching_type = $3.to_i
          @data          = [$4].pack "H*"
        end
      end
      
      def rdata_to_string
        "#{@usage} #{@selector} #{@matching_type} " << @data.unpack('H*')[0]
      end
      
      def encode_rdata(msg, canonical=false) #:nodoc: all
        msg.put_pack('ccc', @usage, @selector, @matching_type)
        msg.put_bytes(@data)
      end
      
      def self.decode_rdata(msg) #:nodoc: all
        args = msg.get_unpack('ccc') << msg.get_bytes
        return self.new(args)
      end
    end
  end
end
