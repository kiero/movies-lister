require 'spec_helper'

describe Movie do
  it "has a valid factory" do
    FactoryGirl.create(:movie).should be_valid
  end

  it "is invalid without title" do
    FactoryGirl.build(:movie, :title => nil).should_not be_valid
  end

  it "is invalid without release" do
    FactoryGirl.build(:movie, :release => nil).should_not be_valid
  end

  it "is invalid without genre" do
    FactoryGirl.build(:movie, :genre => nil).should_not be_valid
  end

  it "is invalid without rate" do
    FactoryGirl.build(:movie, :rate => nil).should_not be_valid
  end

  it "has rate value between 0 and 10" do
    FactoryGirl.build(:movie, :rate => 6).should be_valid
    FactoryGirl.build(:movie, :rate => 12).should_not be_valid
  end
end
