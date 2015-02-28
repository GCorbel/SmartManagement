require 'rails_helper'

describe JsonConverter do
  describe '#call' do
    it 'convert the data in json' do
      data = {
        items: [ {id: 1, name: 'Name 1'}, {id: 2, name: 'Name 2'} ],
        meta: { total: 2 }
      }
      schema = { user: { only: [:id] } }

      actual = JsonConverter.new(data, schema).call
      expected = "{\"items\":[{\"id\":1},{\"id\":2}],\"meta\":{\"total\":2}}"

      expect(actual).to eq expected
    end
  end
end
