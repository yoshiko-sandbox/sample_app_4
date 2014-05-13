require 'spec_helper'
include SessionsHelper

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Micropost creation" do
    before { visit root_path }

    describe "with Invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a Micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "another user's post can't show delete link" do
      let(:another) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit user_path(another)
      end
      it { should_not have_link('delete') }
    end

    describe "self post show delete link" do
      before do
        sign_in user
        visit user_path(user)
      end
      it { should have_link('delete') }
    end

  end
end
