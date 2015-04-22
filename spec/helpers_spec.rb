require 'rails_helper'

class HelpedController
  include SmartManagement::Helpers

  def controller_name
    :users
  end
end

module SmartManagement
  describe Helpers do
    describe '#scope' do
      it 'Give the class of the model' do
        controller = HelpedController.new
        expect(controller.scope).to eq User
      end
    end
  end
end
