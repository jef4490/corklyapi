require "rails_helper"

RSpec.describe Account, :type => :model do

it "expects Account to exist" do
  account = Account.new(username: "jefferson")
  expect(!!account).to eq(true)
end

it "expected Account to not be valid without a password & email address" do
  account = Account.new(username: "peterson")
  expect(account).to_not be_valid
  account.email = "abc@def.com"
  expect(account).to_not be_valid
  account.password = "doremifaso"
  expect(account).to be_valid
end

end
