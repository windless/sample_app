require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "home page" do
    before { visit root_path }
    it { should have_selector('title', :text => 'Sample App') }
    it { should have_selector('h1', :text => 'Sample App') }
    it { should_not have_selector('title', :text => '| Home') }
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
end
