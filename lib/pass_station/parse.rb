# frozen_string_literal: true

# Ruby internal
require 'csv'

# Pass Station module
module PassStation
  # Password database handling
  class DB
    # Register CSV converters for parsing
    def csv_config
      strip_converter = proc { |field| field.strip }
      CSV::Converters[:strip] = strip_converter
      # https://github.com/ruby/csv/issues/208
      # @config[:strip] = true
      # @config[:liberal_parsing] = true
      @config[:headers] = true
      @config[:converters] = :strip
      @config[:header_converters] = :symbol
      @config[:empty_value] = '<blank>'
      @config[:nil_value] = '<blank>'
    end

    # Parse, sort and sanitize the password database
    # @param sort [Symbol] column name to sort by: +:productvendor+, +:username+, +:password+
    # @return [Array<CSV::Row>] table of +CSV::Row+, each row contains three
    #   attributes: :productvendor, :username, :password
    def parse(sort = :productvendor)
      @data = CSV.table(@database_path, **@config).sort_by do |s|
        s[sort].downcase
      end
    end

    protected :csv_config
  end
end
