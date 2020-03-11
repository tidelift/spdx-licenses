$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'mocha/minitest'
require 'spdx-licenses'

class TestSpdxExceptions < Minitest::Test
  def test_exist_unknown
    assert_equal false, SpdxLicenses.exception_exist?('unknown')
  end

  def test_exist_known
    assert_equal true, SpdxLicenses.exception_exist?('DigiRule-FOSS-exception')
  end

  def test_lookup_unknown
    assert_nil SpdxLicenses.lookup_exception('unknown')
  end

  def test_lookup_known
    license = SpdxLicenses::Exception.new('LLVM-exception', 'LLVM Exception', false)
    assert_equal license.id, SpdxLicenses.lookup_exception('LLVM-exception').id
  end

  def test_version
    assert_equal SpdxLicenses::VERSION, SpdxLicenses.version
  end
end
