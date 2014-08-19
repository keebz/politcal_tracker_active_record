require 'spec_helper'
require 'pry'

describe State do
	it "has many representatives" do
    new_state = State.create({name: "Oregon"})
    new_representative = Representative.create({name: "Mr. Smith", state_id: new_state.id})
    expect(new_state.representatives).to eq [new_representative]
  end
    it 'converts the name to capitalize the first letter' do
    new_state = State.create(:name => "oregon")
    new_state.name.should eq "Oregon"
  end
end