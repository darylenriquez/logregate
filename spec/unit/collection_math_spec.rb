require 'helper/spec_helper'

describe CollectionMath do
  describe "self#mean" do
    it "should have method mean" do
      expect(CollectionMath.respond_to?(:mean)).to be true
    end

    context "when argument is empty" do
      it "should return zero" do
        expect(CollectionMath.mean([])).to eq 0
      end
    end

    context "when argument is not empty" do
      let(:collection){ [2,3,4,5,7] }

      it "should return the mean" do
        expect(CollectionMath.mean(collection)).to eq 4
      end
    end
  end

  describe "self#median" do
    it "should have method median" do
      expect(CollectionMath.respond_to?(:median)).to be true
    end

    context "when argument count is odd" do
      let(:collection){ [2,3,4,5,7] }

      it "should return zero" do
        expect(CollectionMath.median(collection)).to eq 4
      end
    end

    context "when argument count is odd" do
      let(:collection){ [2,3,4,5,7,10] }

      it "should return the mean" do
        expect(CollectionMath.median(collection)).to eq 4.5
      end
    end
  end

  describe "self#mode" do
    it "should have method mode" do
      expect(CollectionMath.respond_to?(:mode)).to be true
    end

    context "when there are two modes" do
      let(:collection){ [1,2,3,4,5,6,2,8,1] }

      it "should return zero" do
        expect(CollectionMath.mode(collection)).to eq "1,2"
      end
    end

    context "when there is only one mode" do
      let(:collection){ [1,2,3,4,5,2,2,8,1] }

      it "should return the mean" do
        expect(CollectionMath.mode(collection)).to eq "2"
      end
    end
  end

  describe "self#highest_value" do
    let(:collection){ {p: 4, o:8, l: 2} }

    it "should have method highest_value" do
      expect(CollectionMath.respond_to?(:highest_value)).to be true
    end

    it "should return the keys having the highest value" do
      expect(CollectionMath.highest_value(collection)).to eq [:o]
    end
  end
end