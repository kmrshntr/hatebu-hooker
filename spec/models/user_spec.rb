require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "can_post?" do
    describe "without tags" do
      it { expect(user.can_post?("hatebu_key", "add", "bookmark comment")).to be_true }
      it { expect(user.can_post?("hatebu_key1", "add", "bookmark comment")).to be_false }
      it { expect(user.can_post?("hatebu_key", "delete", "bookmark comment")).to be_false }
    end

    describe "include_tags" do
      describe "1 tag" do
        before { user.update_attributes(include_tags: "tech") }
        it { expect(user.can_post?("hatebu_key", "add", "[tech] bookmark comment")).to be_true }
        it { expect(user.can_post?("hatebu_key", "add", "bookmark comment")).to be_false }
        it { expect(user.can_post?("hatebu_key", "add", "[tech bookmark comment")).to be_false }
      end

      describe "2 tags" do
        before { user.update_attributes(include_tags: "foo bar") }
        it { expect(user.can_post?("hatebu_key", "add", "[tech][foo] bookmark comment")).to be_true }
        it { expect(user.can_post?("hatebu_key", "add", "[bar] bookmark comment")).to be_true }
        it { expect(user.can_post?("hatebu_key", "add", "bookmark comment")).to be_false }
      end
    end

    describe "exclude_tags" do
      describe "1 tag" do
        before { user.update_attributes(exclude_tags: "tech") }
        it { expect(user.can_post?("hatebu_key", "add", "[tech] bookmark comment")).to be_false }
        it { expect(user.can_post?("hatebu_key", "add", "bookmark comment")).to be_true }
        it { expect(user.can_post?("hatebu_key", "add", "[tech bookmark comment")).to be_true }
      end

      describe "2 tags" do
        before { user.update_attributes(exclude_tags: "foo bar") }
        it { expect(user.can_post?("hatebu_key", "add", "[tech][foo] bookmark comment")).to be_false }
        it { expect(user.can_post?("hatebu_key", "add", "[bar] bookmark comment")).to be_false }
        it { expect(user.can_post?("hatebu_key", "add", "bookmark comment")).to be_true }
      end
    end
  end
end
