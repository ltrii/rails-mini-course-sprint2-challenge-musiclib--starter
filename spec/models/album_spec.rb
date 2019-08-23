require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "validations" do
    it "is valid" do
      # instantiate a valid album and ensure it is valid
      album = Album.new(name: "Kid A", available: true)
      result = album.valid?
      error = album.errors.full_message

      expect(result).to be true
      expect(error).to be false
    end

    it "is invalid without a name" do
      # instantiate an album without a name and ensure it is invalid
      album = Album.new(name: nil, available: true)
      result - album.valid?
      error = album.errors.full_message

      expect(result).to be false 
      expect(error).to include("Name can't be blank.")
    end
  end

  describe "attributes" do
    it "has expected attributes" do
      # ensure exactly the expected attributes are present on an album
      album = Album.new(name: "In Rainbows", available: true).attribute_names

      expect(album).to contain_exactly(
        "id", "name", "available", "artist_id", "created_at", "updated_at"
      )
    end
  end

  context "scopes" do
    describe "available" do
      before do 
        Album.create!({
          { name: "ANIMA", available: true },
          { name: "i,i", available: true },
          { name: "22, A Million", available: true },
          { name: "The Eraser", available: true }
        })
      end
      it "returns a list of available albums sorted by name" do
        # set up a some available albums and unavailable albums and make expecations that the
        # available albums scope only returns available albums sorted by name
        result = Album.available
        expect(result.name.first).to eq "a1"
        expect(result.any? { |test1| test1.name == "a3"}).to be false
      end
    end
  end

  describe "#length_seconds" do
  before do
    Album.songs.create!({
      { title: "Paranoid Android", track_number: 1, length_seconds: 300 },
      { title: "Darkshines", track_number: 2, length_seconds: 300},
      { title: "God Only Knows", track_number: 3}, length_seconds: 300 },
      { title: "Woo", track_number: 4, length_seconds: 300 }
    })
  end
    it "calculates the total length in seconds of an album" do
      # setup a valid album and songs and make expecations about the return value of length seconds
      result = album.length_seconds
      
      expect(result).to eq 1200
    end
  end
end