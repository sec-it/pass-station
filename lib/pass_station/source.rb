# frozen_string_literal: true

# Ruby internal
require 'net/https'
require 'tmpdir'

# Pass Station module
module PassStation
  # Password database handling
  class DB
    UPSTREAM_DATABASE = {
      URL: 'https://raw.githubusercontent.com/ihebski/DefaultCreds-cheat-sheet/main/DefaultCreds-Cheat-Sheet.csv',
      HASH: '37604fcbf1691f73c1080439e26fcc04f1b6f493128f1ba7a8120385750662ed'
    }.freeze

    class << self
      # Download upstream password database
      # @param destination_path [String] the destination path (may
      #   overwrite existing file).
      # @param opts [Hash] the optional downlaod parameters.
      # @option opts [String] :sha256 the SHA256 hash to check, if the file
      #   already exist and the hash matches then the download will be skipped.
      # @return [String] the saved file path.
      def download_upstream(destination_path, opts = {})
        download_file(UPSTREAM_DATABASE[:URL], destination_path, opts)
      end

      # Chek if an update is available
      # @return [Boolean] +true+ if there is, +false+ else.
      def check_for_update
        file = download_file(UPSTREAM_DATABASE[:URL], Dir.mktmpdir)
        # Same hash = no update
        !check_hash(file, UPSTREAM_DATABASE[:HASH])
      end

      # Download a file.
      # @param file_url [String] the URL of the file.
      # @param destination_path [String] the destination path (may
      #   overwrite existing file).
      # @param opts [Hash] the optional downlaod parameters.
      # @option opts [String] :sha256 the SHA256 hash to check, if the file
      #   already exist and the hash matches then the download will be skipped.
      # @return [String|nil] the saved file path.
      def download_file(file_url, destination_path, opts = {})
        opts[:sha256] ||= nil

        destination_path += '/' unless destination_path[-1] == '/'
        uri = URI(file_url)
        filename = uri.path.split('/').last
        destination_file = destination_path + filename
        # Verify hash to see if it is the latest
        skip_download = check_hash(destination_file, opts[:sha256])
        write_file(destination_file, fetch_file(uri)) unless skip_download
      end

      # Check if a file match a SHA256 hash
      # @param file [String] the path of the file.
      # @param hash [String] tha SHA256 hash to check against.
      # @return [Boolean] if the hash of the file matched the one provided (+true+)
      #   or not (+false+).
      def check_hash(file, hash)
        if !hash.nil? && File.file?(file)
          computed_h = Digest::SHA256.file(file)
          true if hash.casecmp(computed_h.hexdigest).zero?
        else
          false
        end
      end

      # Just fetch a file
      # @param uri [URI] the URI to of the file
      # @return [Bytes] the content of the file
      def fetch_file(uri)
        res = Net::HTTP.get_response(uri)
        raise "#{file_url} ended with #{res.code} #{res.message}" unless res.is_a?(Net::HTTPSuccess)

        res.body
      end

      # Write a file to disk
      # @param destination_file [String] the file path where the fiel will be
      #   written to disk
      # @param file_content [String] the content to write in the file
      # @return [String] destination file path
      def write_file(destination_file, file_content)
        File.open(destination_file, 'wb') do |file|
          file.write(file_content)
        end
        destination_file
      end

      # https://github.com/lsegal/yard/issues/1372
      protected :download_file, :check_hash, :fetch_file, :write_file
    end
  end
end
