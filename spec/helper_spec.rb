require 'rails_helper'

class HelpedController
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
        expect(HelpedController.new.visible_schema).to eq expected
      end
    end

    describe '#visible_columns' do
      context 'When no columns are specified' do
        it 'Give all columns of the model' do
          expect(HelpedController.new.visible_columns).to eq User.columns
        end
      end

      context 'When some columns are specified' do
        it 'Give only those columns' do
          controller = HelpedController.new
          schema = { user: { only: [:name] } }
          allow(controller).to receive(:visible_schema).and_return(schema)

          expect(controller.visible_columns.size).to eq 1
          expect(controller.visible_columns.first.name).to eq "name"
        end
      end
    end
  end
end
