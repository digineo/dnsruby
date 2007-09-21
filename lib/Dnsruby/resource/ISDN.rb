#--
#Copyright 2007 Nominet UK
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License. 
#You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0 
#
#Unless required by applicable law or agreed to in writing, software 
#distributed under the License is distributed on an "AS IS" BASIS, 
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
#See the License for the specific language governing permissions and 
#limitations under the License.
#++
module Dnsruby
  class RR
    #Net::DNS::RR::ISDN - DNS ISDN resource record
    #RFC 1183 Section 3.2
    class ISDN < RR
      ClassValue = nil #:nodoc: all
      TypeValue = Types::ISDN #:nodoc: all
      
      #The RR's address field.
      attr_accessor :address
      
      #The RR's sub-address field.
      attr_accessor :subaddress
      
      def from_data(data) #:nodoc: all
        @address, @subaddress= data
      end
      
      def from_string(input) #:nodoc: all
        @address, @subaddress = input.split(" ")
      end
      
      def rdata_to_string #:nodoc: all
        return "#{@address} #{@subaddress}"
      end
      
      def encode_rdata(msg) #:nodoc: all
        msg.put_string(@address)
        msg.put_string(@subaddress)
      end
      
      def self.decode_rdata(msg) #:nodoc: all
        address = msg.get_string
        subaddress = msg.get_string
        return self.new([address, subaddress])
      end
    end
  end
end
