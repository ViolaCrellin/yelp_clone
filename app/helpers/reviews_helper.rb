module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    '★' * rating.round + '☆' * (5 - rating)
  end

  def review_recency(created_at)
    t = time_ago_in_words(created_at, :highest_measure_only => true, :vague => :seconds)
    return 'less than 1 minute' if t == "1 minute"
    t 
  end
end
