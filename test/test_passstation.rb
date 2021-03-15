# frozen_string_literal: false

require 'minitest/autorun'
require 'pass_station'
require 'pass_station/output'

# Create a pseudo-Boolean class
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

class PassStattionTest < Minitest::Test
  def setup
    @ps = PassStation::DB.new
    @ps.parse
  end

  def test_DB_attributes_defaults
    ps = PassStation::DB.new
    assert_equal('data/', ps.storage_location)
    assert_equal('DefaultCreds-Cheat-Sheet.csv', ps.database_name)
    assert_nil(ps.data)
  end

  def test_DB_check_for_update
    assert_kind_of(Boolean, PassStation::DB.check_for_update)
  end

  def test_DB_download_upstream
    assert_instance_of(String, PassStation::DB.download_upstream(Dir.mktmpdir))
  end

  def test_DB_parse
    assert_instance_of(Array, @ps.parse)
    assert_instance_of(CSV::Row, @ps.parse[0])
    assert_instance_of(Array, @ps.parse(:username))
    assert_instance_of(CSV::Row, @ps.parse(:password)[0])
  end

  def test_DB_search
    # exists
    assert_instance_of(Array, @ps.search('zyxel', :productvendor))
    assert_instance_of(CSV::Row, @ps.search('zyxel', :productvendor)[0])
    # Doesn't exist
    assert_empty(@ps.search('xdshfiuds6567557657', :username))
  end

  def test_DB_output
    # Types
    assert_instance_of(Array, @ps.output('table', @ps.data))
    assert_instance_of(Array, @ps.output('pretty-table', @ps.data))
    assert_instance_of(String, @ps.output('table', @ps.data)[0])
    assert_instance_of(String, @ps.output('pretty-table', @ps.data)[0])
    # Headers
    assert(@ps.output('table', @ps.data)[0].match?(/productvendor\s+username\s+password\s+/))
    assert(@ps.output('pretty-table', @ps.data)[0].match?(/\+-+\+-+\+-+\+/))
    assert(@ps.output('pretty-table', @ps.data)[1].match?(/|\sproductvendor\s+|\susername\+|\spassword\s+|/))
  end

  def test_DB_output_list
    assert_instance_of(Array, @ps.output_list('table'))
    assert_instance_of(Array, @ps.output_list('pretty-table'))
    assert_instance_of(String, @ps.output_list('table')[0])
    assert_instance_of(String, @ps.output_list('pretty-table')[0])
  end

  def test_DB_output_search
    @ps.search('cisco', :all, sensitive: true)
    assert_instance_of(Array, @ps.output_search('table'))
    assert_instance_of(Array, @ps.output_search('pretty-table'))
    assert_instance_of(String, @ps.output_search('table')[0])
    assert_instance_of(String, @ps.output_search('pretty-table')[0])
  end

  def test_DB_highlight_found
    # String
    @ps.search('Apache', :all, sensitive: true)
    output = @ps.output_search('table')
    assert_instance_of(Array, @ps.highlight_found('Apache', output, sensitive: true))
    assert_instance_of(String, @ps.highlight_found('Apache', output, sensitive: true)[0])
    # Regexp
    @ps.search('password[0-9]+', :password)
    output = @ps.output_search('table')
    assert_instance_of(Array, @ps.highlight_found('password[0-9]+', output, sensitive: false))
    assert_instance_of(String, @ps.highlight_found('password[0-9]+', output, sensitive: false)[0])
  end

  def test_Output_Table_format
    assert_instance_of(Array, PassStation::Output::Table.format(@ps.data))
    assert_instance_of(String, PassStation::Output::Table.format(@ps.data)[0])
  end

  def test_Output_PrettyTable_format
    assert_instance_of(Array, PassStation::Output::PrettyTable.format(@ps.data))
    assert_instance_of(String, PassStation::Output::PrettyTable.format(@ps.data)[0])
  end

  def test_Output_Csv_format
    assert_instance_of(Array, PassStation::Output::Csv.format(@ps.data))
    assert_instance_of(String, PassStation::Output::Csv.format(@ps.data)[0])
  end

  def test_Output_Json_format
    assert_instance_of(Array, PassStation::Output::Json.format(@ps.data))
    assert_instance_of(String, PassStation::Output::Json.format(@ps.data)[0])
  end

  def test_Output_Yaml_format
    assert_instance_of(Array, PassStation::Output::Yaml.format(@ps.data))
    assert_instance_of(String, PassStation::Output::Yaml.format(@ps.data)[0])
  end
end
