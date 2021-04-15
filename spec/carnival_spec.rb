require './lib/ride'
require './lib/attendee'
require './lib/carnival'

RSpec.describe Carnival do
  it 'exists' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    expect(jeffco_fair).to be_instance_of(Carnival)
  end

  it 'has attributes' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    expect(jeffco_fair.name).to eq("Jefferson County Fair")
    expect(jeffco_fair.rides).to eq([])
  end

  it 'can add rides' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    expect(jeffco_fair.rides).to eq([ferris_wheel, bumper_cars, scrambler])
  end

  it 'can recommend rides' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally.add_interest('Scrambler')
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    expect(jeffco_fair.recommend_rides(bob)).to eq([ferris_wheel, bumper_cars])
    expect(jeffco_fair.recommend_rides(sally)).to eq([scrambler])
  end

  it 'admits attendees' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    johnny = Attendee.new("Johnny", 5)
    expect(jeffco_fair.attendees).to eq([])
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)
    expect(jeffco_fair.attendees).to eq([bob, sally, johnny])
  end

  xit 'sorts by interest' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    johnny = Attendee.new("Johnny", 5)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally.add_interest('Scrambler')
    johnny.add_interest('Bumper Cars')
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)
    expect(jeffco_fair.attendees_by_ride_interest).to eq({ferris_wheel => [bob],
                                                          bumper_cars => [bob, johnny],
                                                          scrambler => [sally]
                                                        })
  end

  it 'does a lottery' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    johnny = Attendee.new("Johnny", 5)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally.add_interest('Scrambler')
    johnny.add_interest('Bumper Cars')
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)
    expect(jeffco_fair.ticket_lottery_contestants(bumper_cars)).to eq([bob,johnny])
    expect(jeffco_fair.draw_lottery_winner(bumper_cars)).to eq("Bob").or eq("Johnny")
    #expect(jeffco_fair.draw_lottery_winner(ferris_wheel)).to eq(nil)
  end

  xit 'announces a winner' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    johnny = Attendee.new("Johnny", 5)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally.add_interest('Scrambler')
    johnny.add_interest('Bumper Cars')
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)
    jeffco_fair.announce_lottery_winner(scrambler)
  end

end
