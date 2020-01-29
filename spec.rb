require 'test/unit'
require 'test/unit/ui/console/testrunner'

require_relative 'pto_file'

class TestPtoFile < Test::Unit::TestCase
  def initialize(*)
    super
    @pto_file = nil
  end

  def pto_file(*args, **kw, &block)
    pto_file = PtoFile.new(*args, **kw, &block)
    @pto_file = (pto_file unless block)
  end

  def teardown
    @pto_file&.close!
  end

  def test_object_writing
    expected_text = "Written at #{Time.now}\n"
    file = pto_file('foo.pto', 'w')
    path = file.path
    file.write(expected_text)
    file.close

    assert_equal expected_text, File.read(path)
  end

  def test_block_writing
    filename = 'foo.pto'
    expected_text = "Written at #{Time.now}\n"
    pto_file(filename, 'w') { |f| f.write expected_text }

    file = pto_file(filename)
    path = file.path
    file.close

    assert_equal expected_text, File.read(path)
  end
end

my_tests = Test::Unit::TestSuite.new
my_tests << TestPtoFile.suite

Test::Unit::UI::Console::TestRunner.run(my_tests)
