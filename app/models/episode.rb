class Episode < ActiveRecord::Base
  belongs_to :show, touch: true

  def number_metadata
    format_metadata('S', season) + format_metadata('E', number)
  end

  def formatted_air_time
    air_time
  end

  def same_as?(another_episode)
    comparable(self) == comparable(another_episode)
  end

  private

    def format_metadata(prepended_abbreviation, number)
      "#{prepended_abbreviation}%02d" % number
    end

    def comparable(episode)
      ignored_elements = ['id', 'created_at', 'updated_at']
      episode.attributes.except(*ignored_elements)
    end
end
