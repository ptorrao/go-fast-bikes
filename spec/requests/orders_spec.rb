require 'spec_helper'

describe "Orders" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new order" do
        lambda do
          visit root_path
          fill_in :order_notes, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Order, :count)
      end
    end

    describe "success" do

      it "should make a new order" do
        notes = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :order_notes, :with => notes
          click_button
          response.should have_selector("span.notes", :content => notes)
        end.should change(Order, :count).by(1)
      end
    end
  end
end