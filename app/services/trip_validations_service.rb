# class TripValidationsService
#   include ActiveModel::Validations
#   def initialize(attributes = {})
#     @name = attributes[:name]
#     @start_date = attributes[:start_date]
#     @end_date = attributes[:end_date]
#   end

#   validates :name, presence: true, uniqueness: true
#   validates :places, uniqueness: true
#   validate :start_date_cannot_be_in_the_past, :end_date_after_start_date?

#   def start_date_cannot_be_in_the_past
#     if params[:start_date].present?
#       errors.add(:start_date, "Your start date can't be today!")
#     elsif params[:start_date] < Date.today
#       errors.add(:start_date, "Stop living in the past! Choose a date later than today :)")
#     end
#   end

#   def end_date_after_start_date?
#     if params[:end_date] < params[:start_date]
#       errors.add(:end_date, "Your end date must be after your start date :)")
#     end
#   end
# end
