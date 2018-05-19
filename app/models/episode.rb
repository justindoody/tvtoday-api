class Episode < ApplicationRecord
  belongs_to :show, touch: true

  def number_metadata
    format_metadata('S', season).to_s + format_metadata('E', number).to_s
  end

  def formatted_air_time
    air_time.strftime('%l:%M %p') if air_time.present?
  end

  private

    def format_metadata(prepended_abbreviation, number)
      "#{prepended_abbreviation}%02d" % number if number.present?
    end

end
