# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before do 
    @user = User.new(:name => 'Example', :email => 'user@example.com',
                     :password => "foobar", :password_confirmation => "foobar") 
  end
  subject { @user }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  context "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  context "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  context "when email format is valid" do
    it "is valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end    
    end
  end

  context "when email format is not valid" do
    it "is not valid" do
     addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end   
    end
  end

  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context "when password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  context "when password confirmation is not present" do
    before { @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  context "when password confirmation is no match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  context "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  context "when password is too short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

end
