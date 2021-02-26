# frozen_string_literal: true

# Ruby internal
require 'csv'

# Pass Station module
module PassStation
  # Password database handling
  class DB
    # Register CSV converters for parsing
    def csv_config
      strip_converter = proc { |field| field.strip if field.is_a?(String) }
      CSV::Converters[:strip] = strip_converter
    end

    # Parse, sort and sanitize the password database
    # @return [CSV::Table] able of +CSV::Row+, eacho row contains three
    #   attributes: :productvendor, :username, :password.
    def parse
      @data = CSV.table(@database_path, headers: true, converters: :strip, header_converters: :symbol).sort_by do |s|
        s[:productvendor].downcase
      end
    end

    protected :csv_config
  end
end
