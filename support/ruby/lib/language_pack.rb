require "pathname"

# General Language Pack module
module LanguagePack

  # detects which language pack to use
  # @param [Array] first argument is a String of the build directory
  # @return [LanguagePack] the {LanguagePack} detected
  def self.detect(*args)
    Instrument.instrument 'detect' do
      Dir.chdir(args.first)

      pack = [ NoLockfile, Rack, Ruby ].detect do |klass|
        klass.use?
      end

      pack ? pack.new(*args) : nil
    end
  end

end


$:.unshift File.expand_path("../../../../vendor", __FILE__)

require 'dotenv'
require 'language_pack/instrument'
require "language_pack/ruby"
require "language_pack/rack"
require "language_pack/no_lockfile"


