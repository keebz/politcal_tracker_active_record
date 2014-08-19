require 'spec_helper'

describe Funder do
  it "has and belongs to many respesentatives" do
    new_funder = Funder.create(name: "wal mart")
    new_state = State.create({name: "oregon"})
    new_representative = new_state.representatives.create({name: "mr.smith"})
    new_funder.representatives << new_representative
    expect(new_funder.representatives).to eq [new_representative]
  end
end