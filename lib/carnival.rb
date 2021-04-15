class Carnival
  attr_reader :name, :rides, :attendees
  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def recommend_rides(attendee)
    favored_rides =[]
    @rides.each do |ride|
      if attendee.interests.include?(ride.name)
        favored_rides.push(ride)
      end
    end
    favored_rides
  end

  def admit(attendee)
    @attendees.push(attendee)
  end
   #
   # def attendees_by_ride_interest
   #   ride_hash = {}
   #   @rides.each do |ride|
   #     ride_hash[ride] = @attendees.group_by do |attendee|
   #
   def ticket_lottery_contestants(ride)
     contestants = []
     @attendees.each do |attendee|
       if attendee.interests.include?(ride.name)
         require "pry"; binding.pry
         contestants.push(attendee)
       end
     end
     contestants
   end

   def draw_lottery_winner(ride)
     contestants = ticket_lottery_contestants(ride)
     winner = contestants.sample
     winner.name
   end

end
