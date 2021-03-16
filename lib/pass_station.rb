# frozen_string_literal: true

# Ruby internal
require 'pathname'
# Project internal
require 'pass_station/source'
require 'pass_station/parse'
require 'pass_station/search'
require 'pass_station/version'

# Pass Station module
module PassStation
  # Constants
  include Version

  # Password database handling
  class DB
    # Get / set storage location, where will be stored the password database.
    # @return [String] database storage location. Default to +data/+.
    attr_accessor :storage_location

    # Get / set the password database name
    # @return [String] password database filename. Default to
    #   +DefaultCreds-Cheat-Sheet.csv+.
    attr_accessor :database_name

    # Get the password database in +Array<CSV::Row>+ format
    # @return [Array<CSV::Row>] pasword database
    attr_reader :data

    # A new instance of Pass Station
    def initialize
      @storage_location = 'data/'
      @database_name = 'DefaultCreds-Cheat-Sheet.csv'
      @database_path = absolute_db_path
      database_exists?
      @config = {}
      csv_config
      @data = nil
      @search_result = []
    end

    # Find the absolute path of the DB from its relative location
    # @return [String] absolute filename of the DB
    def absolute_db_path
      pn = Pathname.new(__FILE__)
      install_dir = pn.dirname.parent.to_s + Pathname::SEPARATOR_LIST
      install_dir + @storage_location + @database_name
    end

    # Check if the password database exists
    # @return [Boolean] +true+ if the file exists
    def database_exists?
      exists = File.file?(@database_path)
      raise "Database does not exist: #{@database_path}" unless exists

      exists
    end

    protected :database_exists?, :absolute_db_path
  end
end
