require 'json'
require_relative 'spdx-licenses/license'
require_relative 'spdx-licenses/exception'
require_relative 'spdx-licenses/version'

module SpdxLicenses
  def self.exceptions
    unless defined?(@@exceptions)
      data = JSON.load(File.read(File.expand_path('../../exceptions.json', __FILE__)))
      @@exceptions = {}
      data['exceptions'].each do |details|
        id = details.delete('licenseExceptionId')
        @@exceptions[id] = details
      end
    end
    @@exceptions
  end

  def self.licenses
    unless defined?(@@licenses)
      data = JSON.load(File.read(File.expand_path('../../licenses.json', __FILE__)))
      @@licenses = {}
      data['licenses'].each do |details|
        id = details.delete('licenseId')
        @@licenses[id] = details
      end
    end
    @@licenses
  end

  def self.lookup(id)
    entry = licenses[id.to_s]
    SpdxLicenses::License.new(id.to_s, entry['name'], entry['isOsiApproved']) if entry
  end

  def self.exist?(id)
    licenses.has_key? id.to_s
  end

  def self.lookup_exception(id)
    entry = exceptions[id.to_s]
    SpdxLicenses::Exception.new(id.to_s, entry['name'], entry['isDeprecatedLicenseId']) if entry
  end

  def self.exception_exist?(id)
    exceptions.has_key? id.to_s
  end

  def self.version
    VERSION
  end

  class << self
    alias_method :[], :lookup
    alias_method :exists?, :exist?
  end
end
