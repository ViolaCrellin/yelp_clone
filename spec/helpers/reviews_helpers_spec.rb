require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  describe '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  describe '#review_recency' do
    before do
      test_time = Time.new(2016, 03, 5, 13, 0, 30)
      Timecop.freeze(test_time)
    end
    after do
      Timecop.return
    end


    it 'measures time elapsed since review to the closest minute' do
      test_time_seconds = Time.new(2016, 03, 5, 13, 01, 0)
      expect(helper.review_recency(test_time_seconds)).to eq 'less than 1 minute'
    end

    it 'measures time elapsed since review in the closest minute' do
      test_time_minutes = Time.new(2016, 03, 5, 12, 11, 00)
      expect(helper.review_recency(test_time_minutes)).to eq 'about 1 hour'
    end

    it 'measures time elapsed since review in the closest hour' do
      test_time_hour = Time.new(2016, 03, 5, 12, 00, 00)
      expect(helper.review_recency(test_time_hour)).to eq 'about 1 hour'
    end

    it 'measures time elapsed since review in the closest number of days' do
      test_time_days = Time.new(2016, 03, 3, 13, 00, 00)
      expect(helper.review_recency(test_time_days)).to eq '2 days'
    end

    it 'is able to cope with plurals versus singulars' do
      test_time_minute = Time.new(2016, 03, 5, 12, 59, 00)
      test_time_day = Time.new(2016, 03, 4, 12, 59, 00)
      test_time_hours = Time.new(2016, 03, 5, 11, 00, 00)
      expect(helper.review_recency(test_time_day)).to eq '1 day'
      expect(helper.review_recency(test_time_hours)).to eq 'about 2 hours'
      expect(helper.review_recency(test_time_minute)).to eq '2 minutes'
    end
  end
end
