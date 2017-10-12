class SearchController < ApplicationController

  def index
    results = ActivitiesCategories::CATEGORIES.flatten.each_with_object({}) do |category, a|
      a[category] ||= []
      a[category] += FetchActivitiesService.new(category, params[:place]).()
    end

    h_activities = []

    Activity.bulk_insert(ignore: true) do |worker|
      results.each do |category, activities|
        activities.each do |activity|
          activity['category'] = category
          activity['yelp_id'] = activity['id']
          activity.delete('id')
          activity['latitude'] = activity['coordinates']['latitude']
          activity['longitude'] = activity['coordinates']['longitude']
          activity.delete('coordinates')
          activity['place_name'] = activity['location']['city']
          activity['display_address'] = activity['location']['display_address'].join(' ')
          activity.delete('location')
          worker.add(activity)
          h_activities << activity
        end
      end
    end

    activities = Activity.where(yelp_id: h_activities.map { |r| r['yelp_id'] }).to_a

    render json: {categories: activities.map(&:category).uniq, activities: activities}
  end

end
