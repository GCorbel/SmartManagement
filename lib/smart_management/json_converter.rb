class JsonConverter
  attr_accessor :data, :schema

  def initialize(data, schema)
    @data = data
    @schema = schema
  end

  def call
    hash = {}
    hash[:items] = data.items.as_json(schema)
    hash[:meta] = { total: data.total }
    hash.to_json
  end
end
