class Show < ActiveRecord::Base
  has_many :episodes, dependent: :destroy
  belongs_to :previous_episode, class_name: 'Episode', dependent: :destroy
  belongs_to :next_episode, class_name: 'Episode', dependent: :destroy

  scope :active, ->{ where(canceled: false) }
  scope :canceled, ->{ where(canceled: true) }
  scope :by_nearest_next_episode_date, ->{ joins("LEFT OUTER JOIN episodes on episodes.id = shows.next_episode_id").order('episodes.air_date ASC NULLS LAST')}

  after_save :invalidate_cache
  after_touch :invalidate_cache
  after_create { Rails.cache.delete('all_shows') }

  validates :name, :tvdbId, presence: true
  validates_uniqueness_of :tvdbId

  def outdated_data?(client_updated_at)
    client_updated_at.to_i != updated_at.to_i
  end

  private

    def invalidate_cache
      Rails.cache.delete("tvdbid/#{tvdbId}")
    end

end
