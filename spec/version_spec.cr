require "./spec_helper"

describe Version do
  # TODO: Write tests

  it "works" do
    Version::VERSION.should eq("0.1.0")
  end
end

describe Version::Requirement do
  it "works" do 
    any = Version::Requirement.parse("*")
    equal = Version::Requirement.parse("2.0.0")
    equal_2 = Version::Requirement.parse("= 2.0.0")
    less = Version::Requirement.parse("<0.1.5")
    greater_or_eq = Version::Requirement.parse(">= 0.0.1")
    approx = Version::Requirement.parse("~> 3.2.5")
    any2 = Version::Requirement.parse("")

    any.matches?("13.0.0").should eq(true)
    any2.matches?("10.34.0").should eq(true)
    equal.matches?("2.0.0").should eq(true)
    equal.matches?("2.0.1").should eq(false)
    equal_2.matches?("2.0.2").should eq(false)
    equal_2.matches?("2.0.0").should eq(true)
    less.matches?("0.1.5").should eq(false)
    less.matches?("0.1.4").should eq(true)
    greater_or_eq.matches?("0.0.1").should eq(true)
    approx.matches?("3.2.4").should eq(false)
    approx.matches?("3.2.5").should eq(true)
    approx.matches?("3.2.9").should eq(true)
    approx.matches?("3.3.0").should eq(false)
  end
end

describe Version::RequirementSet do 
  it "works" do 
    req_set = Version::RequirementSet.parse ">= 1.0.0, < 3.0.0, != 2.5.6"

    req_set.matches?("0.9.9").should eq(false)
    req_set.matches?("1.0.0").should eq(true)
    req_set.matches?("1.0.1").should eq(true)
    req_set.matches?("2.5.5").should eq(true)
    req_set.matches?("2.5.6").should eq(false)
    req_set.matches?("3.0.0").should eq(false)
  end
end