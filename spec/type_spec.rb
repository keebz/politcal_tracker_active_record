require 'spec_helper'
require 'pry'

describe Type do
	it "has many representatives" do
    new_type = Type.create({name: "Senate"})
    new_representative = Representative.create({name: "Mr. Smith", type_id: new_type.id})
    expect(new_type.representatives).to eq [new_representative]
  end
end