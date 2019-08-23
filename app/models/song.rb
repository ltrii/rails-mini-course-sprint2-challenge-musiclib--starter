class Song < ApplicationRecord
  belongs_to :album
  has_many :playlists, through: :playlistsongs
  has_many :playlist_songs, through: :playlistsongs

  validates :track_number, :length_seconds, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :title, presence: true
end
