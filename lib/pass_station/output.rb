# frozen_string_literal: true

# Ruby internal
require 'csv'
require 'json'
require 'yaml'
# External dependencies
require 'paint'

# Pass Station module
module PassStation
  # Password database handling
  class DB
    # Output the data in the chosen format
    # @param formatter [String] Engine to use to format the data: +table+, +'pretty-table'+, +JSON+, +CSV+, +YAML+
    # @param data [CSV::Table]
    # @return [Array<String>] formatted output
    def output(formatter, data)
      # Convert string to class
      Object.const_get("PassStation::Output::#{normalize(formatter)}").format(data)
    end

    # Output the data in the chosen format (list command)
    # @param formatter [String] Engine to use to format the data: +table+, +'pretty-table'+, +JSON+, +CSV+, +YAML+
    # @return [Array<String>] formatted output
    def output_list(formatter)
      data_nil?
      output(formatter, @data)
    end

    # Output the data in the chosen format (search command)
    # @param formatter [String] Engine to use to format the data: +table+, +'pretty-table'+, +JSON+, +CSV+, +YAML+
    # @return [Array<String>] formatted output
    def output_search(formatter)
      return '[-] No result' if @search_result.empty?

      output(formatter, @search_result)
    end

    # Highlight (colorize) a searched term in the input
    # When used with the search command, it will ignore in which column the
    # search was made, and will instead colorize in every columns.
    # @param term [String] the searched term
    # @param text [String] the output in which the colorization must be made
    # @param sensitive [Boolean] case sensitive or not
    # @return [Array<String>] colorized output
    def highlight_found(term, text, sensitive)
      text.map do |x|
        rgxp = build_regexp(term, sensitive: sensitive)
        x.gsub(rgxp) { |s| Paint[s, :red] }
      end
    end

    # Raise an error is data attribute is nil
    def data_nil?
      raise 'You must use the parse method to polutate the data attribute first' if @data.nil?
    end

    # Normalize string to be class name compatible
    # Join splitted words and capitalize
    # @param formatter [String] formatter name
    # @return [String] normalized name (class compatible)
    def normalize(formatter)
      formatter.split('-').map(&:capitalize).join
    end

    protected :normalize, :data_nil?
  end

  # Output handling module containing all formatter engines
  # Meant to be used by the CLI binary but could be re-used in many other ways
  module Output
    # Simple table formatter
    class Table
      class << self
        # Format the +CSV::Table+ into a simple table with justified columns
        # @param table [CSV::Table] a +CSV::Table+
        # @return [Array<String>] the formatted table ready to be printed
        def format(table)
          out = []
          colsizes = colsizes_count(table)
          out.push(headers(colsizes))
          table.each do |r|
            out.push(justify_row(r, colsizes))
          end
          out
        end

        # Calculate column size (max item size)
        # @param table [CSV::Table]
        # @param column [Symbol] the symbol of the column
        # @return [Integer] the column size
        def colsize_count(table, column)
          table.map { |i| i[column].nil? ? 0 : i[column].size }.max + 1
        end

        # Calculate the size of all columns (max item size)
        # @param table [CSV::Table]
        # @return [Hash] keys are columns name, values are columns size
        def colsizes_count(table)
          colsizes = table.first.to_h.keys.each_with_object({}) do |c, h|
            h[c] = colsize_count(table, c)
          end
          correct_min_colsizes(colsizes)
        end

        # Correct colsizes to be at least of the size of the headers (case when
        # values are shorter than headers and breaks the table display)
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [Hash] fixed colsizes, keys are columns name, values are columns size
        def correct_min_colsizes(colsizes)
          min_colsizes = {
            productvendor: 14,
            username: 9,
            password: 9
          }
          min_colsizes.each_with_object({}) { |(k, v), h| h[k] = [v, colsizes[k]].max }
        end

        # Left justify an element of the column
        # @param row [CSV::Row] +CSV::Row+
        # @param column [Symbol] the symbol of the column
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified element
        def justify(row, column, colsizes)
          row[column].to_s.ljust(colsizes[column])
        end

        # Left justify all elements of the column
        # @param row [CSV::Row] +CSV::Row+
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified row
        def justify_row(row, colsizes)
          out = ''
          row.to_h.each_key do |col|
            out += justify(row, col, colsizes)
          end
          out
        end

        # Generate justified headers
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified headers
        def headers(colsizes)
          colsizes.map { |k, v| k.to_s.ljust(v) }.join.to_s
        end

        protected :colsize_count, :colsizes_count, :justify, :justify_row, :headers, :correct_min_colsizes
      end
    end

    # Pretty table with ASCII borders formatter
    class PrettyTable < Table
      class << self
        # Format the +CSV::Table+ into a simple table with justified columns
        # @param table [CSV::Table] a +CSV::Table+
        # @return [Array<String>] the formatted table ready to be printed
        def format(table)
          out = []
          colsizes = colsizes_count(table)
          out.push(dividers(colsizes))
          out.push(headers(colsizes))
          out.push(dividers(colsizes))
          table.each do |r|
            out.push(justify_row(r, colsizes))
          end
          out.push(dividers(colsizes))
        end

        # Left justify an element of the column
        # @param row [CSV::Row] +CSV::Row+
        # @param column [Symbol] the symbol of the column
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified element
        def justify(row, column, colsizes)
          row[column].to_s.ljust(colsizes[column] - 1)
        end

        # Left justify all elements of the column
        # @param row [CSV::Row] +CSV::Row+
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified row
        def justify_row(row, colsizes)
          out = '| '
          row.to_h.each_key do |col|
            out += "#{justify(row, col, colsizes)} | "
          end
          out
        end

        # Generate dividers
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] divider line
        def dividers(colsizes)
          "+#{colsizes.map { |_, cs| '-' * (cs + 1) }.join('+')}+"
        end

        # Generate justified headers
        # @param colsizes [Hash] hash containing the column size for each column as returned by {colsizes_count}
        # @return [String] the justified headers
        def headers(colsizes)
          "| #{colsizes.map { |k, v| k.to_s.ljust(v - 1) }.join(' | ')} |"
        end

        protected :dividers, :headers, :justify_row, :justify
      end
    end
  end
end
