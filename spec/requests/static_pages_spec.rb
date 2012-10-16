require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "home page" do
    before { visit root_path }
    it { should have_selector('title', :text => 'Sample App') }
    it { should have_selector('h1', :text => 'Sample App') }
    it { should_not have_selector('title', :text => '| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create :user }
      before do
        FactoryGirl.create(:micropost, :user => user, :content => "Lorem ipsum")
        FactoryGirl.create(:micropost, :user => user, :content => "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "renders the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", :text => item.content)
        end
      end
    end
  end

  describe "help page" do
    before { visit help_path }
    it { should have_selector('title', :text => 'Help') }
    it { should have_selector('h1', :text => 'Help') }
  end

  describe "about page" do
    before { visit about_path }
    it { should have_selector('title', :text => 'About Us') }
    it { should have_selector('h1', :text => 'About Us') }
  end

  describe "contact page" do
    before { visit contact_path }
    it { should have_selector('title', :text => 'Contact') }
    it { should have_selector('h1', :text => 'Contact') }
  end
end
