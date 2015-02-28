class JsonConverter
  attr_accessor :data, :schema

  def initialize(data, schema)
    @data = data
    @schema = schema
  end

  def call
    data[:items] = data[:items].as_json(schema[schema.keys.first])
    data.to_json
  end
end
