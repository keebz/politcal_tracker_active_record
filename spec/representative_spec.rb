require 'spec_helper'
require 'pry'

describe Representative do
  it "should validate presence of name" do
    new_representative = Representative.create({name: ""})
    expect(new_representative.save).to eq false
  end
end