class CsvConverter
  attr_accessor :json, :columns, :rows

  def initialize(json)
    @json = json
    @rows = []
    @columns = []
    convert
  end

  def write(filename)
    File.open(filename, 'w') do |out|
      out.puts quoted(template_row.keys).join(',')

      @rows.each do |row|
        values = quoted template_row.dup.merge(row).values
        out.puts values.join(',')
      end
    end
  end

  protected

  def quoted(values)
    values.map do |value|
      String === value ? "\"#{ value.gsub('"', '\'') }\"" : value
    end
  end

  def template_row
    @template_row ||= { }.tap do |template|
      @columns.each{ |key| template[key] = nil }
    end
  end

  def convert
    @json.each do |hash|
      row = transform hash
      @rows << row
      @columns |= row.keys
    end
  end

  def transform(object, prefix = nil)
    case object
    when Hash
      merge_hash object, prefix
    when Array
      merge_array object, prefix
    else
      object
    end
  end

  def merge_hash(object, prefix)
    { }.tap do |flattened_object|
      object.each_pair do |key, value|
        flattened_object.merge! flattened_value(value, prefix, key)
      end
    end
  end

  def merge_array(object, prefix)
    { }.tap do |flattened_object|
      object.map.with_index do |value, index|
        flattened_object.merge! flattened_value(value, prefix, index)
      end
    end
  end

  def flattened_value(value, prefix, key)
    flat_key = [prefix, key].compact.join('.')
    if Hash === value || Array === value
      transform value, flat_key
    else
      { flat_key => transform(value, flat_key) }
    end
  end
end
