# frozen_string_literal: true

# Project internal
require 'pass_station/source'
require 'pass_station/parse'
require 'pass_station/version'

# Pass Station module
module PassStation
  # Constants
  include Version

  # Password database handling
  class DB
    # Get / set storage location, where will be stored the password database.
    # @return [String] database storage location. Default to +data/+.
    # @example
    #   PassStation.storage_location = '/srv/downloads/'
    attr_accessor :storage_location

    # Get / set the password database name
    # @return [String] password database filename. Default to
    #   +DefaultCreds-Cheat-Sheet.csv+.
    attr_accessor :database_name

    attr_reader :data

    # A new instance of Pass Station
    def initialize
      @storage_location = 'data/'
      @database_name = 'DefaultCreds-Cheat-Sheet.csv'
      @database_path = @storage_location + @database_name
      database_exists?
      @config = {}
      csv_config
      @data = nil
    end

    # Check if the password database exists
    # @return [Boolean] +true+ if the file exists
    def database_exists?
      exists = File.file?(@database_path)
      raise "Database does not exist: #{@database_path}" unless exists

      exists
    end

    protected :database_exists?
  end
end
