require 'rails_helper'

class HelpedClass
  include SmartManagement::Helpers

  def controller_name
    :users
  end
end

module SmartManagement
  describe Helpers do
    describe '#visible_schema' do
      it 'Give the schema of the model' do
        columns = [ :id, :name, :age, :company_id, :created_at, :updated_at ]
        expected = { user: { only: columns } }
        expect(HelpedClass.new.visible_schema).to eq expected
      end
    end
  end
end
