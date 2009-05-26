require 'test/unit'
require 'dnsruby'

class Nsec3ParamTest < Test::Unit::TestCase
  INPUT = "example. 3600 IN NSEC3PARAM 1 0 12 aabbccdd"

  include Dnsruby
  def test_nsec_from_string
    nsec = Dnsruby::RR.create(INPUT)

    assert_equal(Dnsruby::Algorithms.RSAMD5, nsec.hash_alg)
    assert_equal(0, nsec.flags)
    assert_equal(12, nsec.iterations)
    assert_equal("aabbccdd", nsec.salt)
    
    nsec2 = Dnsruby::RR.create(nsec.to_s)
    assert(nsec2.to_s == nsec.to_s)
  end

  def test_nsec_from_data
    nsec = Dnsruby::RR.create(INPUT)
    m = Dnsruby::Message.new
    m.add_additional(nsec)
    data = m.encode
    m2 = Dnsruby::Message.decode(data)
    nsec3 = m2.additional()[0]
    assert_equal(nsec.to_s, nsec3.to_s)

  end
  
end