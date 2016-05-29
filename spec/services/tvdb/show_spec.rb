describe Tvdb::Show do
  describe '#find_latest_episodes' do
    let(:show) { create(:show) }
    let(:tvdb_service) { described_class.new(show) }

    before { tvdb_service.find_latest_episodes }

    it 'finds and update the latest episodes' do
      expect(show.previous_episode).to be_truthy
    end
  end
end
