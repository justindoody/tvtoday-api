class Show < ActiveRecord::Base
  has_many :episodes
  # has_one :previous_episode, ->{ where(kind: 'previous') }, class_name: 'Episode', dependent: :destroy, autosave: true
  # has_one :next_episode, ->{ where(kind: 'next') }, class_name: 'Episode', dependent: :destroy, autosave: true
  # has_one :previous_episode, ->{ all.order(air_date: :asc).take }, class_name: 'Episode', dependent: :destroy, autosave: true
  # has_one :next_episode, ->{ all.order(air_date: :desc).take }, class_name: 'Episode', dependent: :destroy, autosave: true

  before_validation :set_defaults

  # after_save :invalidate_cache
  # after_touch :invalidate_cache
  # after_create { Rails.cache.delete('all_shows') }

  # validates :name, :tvdbId, presence: true
  # validates_uniqueness_of :tvdbId

  def outdated_data?(client_updated_at)
    client_updated_at.to_i != updated_at.to_i
  end

  private

    def set_defaults
      self.canceled ||= false
    end

    def invalidate_cache
      Rails.cache.delete("tvdbid/#{tvdbId}")
    end
end
