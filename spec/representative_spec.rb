require 'spec_helper'
require 'pry'

describe Representative do
  it "should validate presence of name" do
    new_representative = Representative.create({name: ""})
    expect(new_representative.save).to eq false
  end

  it "has many and belongs to funders" do
    new_representative = Representative.create({name: "Mr. Smith"})
    new_funder = new_representative.funders.create({name: "Wal-Mart"})
    expect(new_representative.funders).to eq [new_funder]
  end
end