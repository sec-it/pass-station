# frozen_string_literal: true

# Ruby internal
require 'csv'
require 'json'
require 'yaml'

# Pass Station module
module PassStation
  # Password database handling
  class DB
    # Output the data in the chosen format
    # @param formatter [String] Engine to use to format the data: +table+, +'pretty-table'+, +JSON+, +CSV+, +YAML+
    # @return [Table] formatted output
    def output(formatter)
      # Convert string to class
      Object.const_get("PassStation::Output::#{normalize(formatter)}").format(@data)
    end

    # Normalize string to be class name compatible
    # Join splitted words and capitalize
    # @param formatter [String] formatter name
    # @return [String] normalized name (class compatible)
    def normalize(formatter)
      formatter.split('-').map(&:capitalize).join
    end

    protected :normalize
  end

  # Output handling module containing all formatter engines
  # Meant to be used by the CLI binary but could be re-used in many other ways
  module Output
    # Simple table formatter
    class Table
      class << self
        # Format the +CSV::Table+ into a simple table with justified columns
        # @param table [CSV::Table|Array<Array>] a +CSV::Table+ or any 2D array
        # @return [Array<String>] the formatted table ready to be printed
        def format(table)
          out = []
          colsize = colsizes_count(table)
          table.each do |r|
            out.push(justify_row(r, colsize))
          end
          out
        end

        # Calculate column size (max item size)
        # @param table [CSV::Table|Array<Array>]
        # @param column [Symbol|Integer] the symbol of the column for +CSV::Table+ or the index integer for a classic
        #   array
        # @return [Integer] the column size
        def colsize_count(table, column)
          table.map { |i| i[column].nil? ? 0 : i[column].size }.max
        end

        # Calculate the size of all columns (max item size)
        # @param table [CSV::Table|Array<Array>]
        # @return [Hash] keys are columns name, values are columns size
        def colsizes_count(table)
          table.first.to_h.keys.each_with_object({}) do |c, h|
            h[c] = colsize_count(table, c)
          end
        end

        # Left justify an element of the column
        # @param row [CSV::Row|Array] +CSV::Row+ for a +CSV::Table+ or an array for a 2D array
        # @param column [Symbol|Integer] the symbol of the column for +CSV::Table+ or the index integer for a classic
        #   array
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified element
        def justify(row, column, colsizes)
          row[column].to_s.ljust(colsizes[column])
        end

        # Left justify all elements of the column
        # @param row [CSV::Row|Array] +CSV::Row+ for a +CSV::Table+ or an array for a 2D array
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified row
        def justify_row(row, colsizes)
          out = ''
          row.to_h.each_key do |col|
            out += justify(row, col, colsizes)
          end
          out
        end

        protected :colsize_count, :colsizes_count, :justify, :justify_row
      end
    end
  end
end
