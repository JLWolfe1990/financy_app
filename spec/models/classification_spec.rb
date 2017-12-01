require 'rails_helper'

RSpec.describe Classification, type: :model do
  let :classification do
    Classification.create group: Classification.groups[:mixed], name: 'very interesting'
  end

  context '#display_name' do
    subject {classification.display_name}
    it 'should display correctly' do
      expect(subject).to eq('Mixed::Very Interesting')
    end
  end
end
