require 'csv'

# It's probably best to integration test this rather than unit test
RSpec.describe CsvConverter, type: :lib do
  let(:json){ CsvConverterSample }
  let(:converter){ CsvConverter.new json }
  let(:tempfile){ Tempfile.new.path }
  subject do
    converter.write tempfile
    CSV.parse(File.read(tempfile), headers: true).map &:to_h
  end

  its(:length){ is_expected.to eql 3 }

  its([0]) do
    is_expected.to eql({
          'a' => '1',
      'b.c.0' => 'a',
      'b.c.1' => 'b',
      'b.c.2' => 'c',
      'c.0.a' => '1',
      'c.0.b' => '2',
      "d.'a'" => '1',
      'b.c.3' => nil
    })
  end

  its([1]) do
    is_expected.to eql({
          'a' => '2',
      'b.c.0' => 'd',
      'b.c.1' => 'e',
      'b.c.2' => 'f',
      'c.0.a' => '2',
      'c.0.b' => '3',
      "d.'a'" => '2',
      'b.c.3' => "'g'"
    })
  end

  its([2]) do
    is_expected.to eql({
          'a' => '3',
      'b.c.0' => nil,
      'b.c.1' => nil,
      'b.c.2' => nil,
      'c.0.a' => nil,
      'c.0.b' => nil,
      "d.'a'" => '3',
      'b.c.3' => nil
    })
  end
end
