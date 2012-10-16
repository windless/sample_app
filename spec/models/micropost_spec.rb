# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create :user }
  before { @micropost = user.microposts.build(:content => "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  its(:user) { should == user }

  it { should be_valid }

  context "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  context "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  context "with too long content" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "does not allow access to user_id" do
      expect do 
        Micropost.new(:user_id => user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
