require 'spec_helper'
require 'pry'

describe Party do
	it "has many representatives" do
    new_party = Party.create({name: "Republican"})
    new_representative = Representative.create({name: "Mr. Smith", party_id: new_party.id})
    binding.pry
    expect(new_party.representatives).to eq [new_representative]
  end
end