require 'rails_helper'

describe Episode do
  let(:episode) { create(:episode) }

  describe '#number_metadata' do
    context 'single digit numbers' do
      let(:episode) { create(:episode, season: 1, number: 3) }

      it 'formats and prepends zeros to single digits' do
        expect(episode.number_metadata).to eq 'S01E03'
      end
    end

    context 'double digit numbers' do
      let(:episode) { create(:episode, season: 10, number: 23) }

      it 'formats and prepends zeros to single digits' do
        expect(episode.number_metadata).to eq 'S10E23'
      end
    end
  end

  describe '#formatted_air_time' do
    before { episode.air_time = "10:00 pm" }

    it 'formats the airtime correctly' do
      expect(episode.formatted_air_time).to eq "10:00 PM"
    end
  end
end
