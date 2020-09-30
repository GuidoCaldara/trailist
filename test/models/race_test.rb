require 'test_helper'

class RaceTest < ActiveSupport::TestCase

  test "should save a valid race" do
    race = races(:valid_race)
    race.location = "Albino, Bg Italy"
    race.save
    refute race.errors.any?, "should save a valid race"
    assert race.errors.empty?, 'should save a valid race'
  end

  test "should not save race without a name" do
    race = races(:valid_race_two)
    race.name = nil
    refute race.valid?, "The race has been saved without a name"
    assert_not_nil !race.errors[:name], 'The race has not been saved without a name'
  end

  test "should not save race with a non unique name" do
    first_race = races(:valid_race)
    second_race = races(:valid_race_two)
    refute second_race.valid?, "The race has been saved with a duplicate name"
    assert_not_nil second_race.errors[:name], 'The race has not been saved without a name'
  end

  test "should not save race without a race_type" do
    race = races(:valid_race_two)
    race.race_type = nil
    refute race.valid?, "The race has been saved without a race type"
    assert_not_nil race.errors[:race_type], 'The race has not been saved without a name'
  end

  test "should not save race with a non standard race_type" do
    race = races(:valid_race_two)
    race.race_type = "XXXXX"
    refute race.valid?, "The race has been saved with a non standard race type"
    assert_not_empty race.errors[:race_type],'The race has not been saved with a non standard race type'
  end

  test "should not save race with a non-numeric length" do
    race = races(:valid_race_two)
    race.length = "XXXXX"
    refute race.valid?, "The race has been saved with a non numeric length"
    assert_not_empty race.errors[:length],'The race has not been saved with a non numeric length'
  end

  test "should not save race with a length < than 0" do
    race = races(:valid_race_two)
    race.length = -20
    refute race.valid?, "The race has been saved with a length < than 0"
    assert_not_empty race.errors[:length],'The race has not been saved with a length < than 0'
  end

  test "should not save race with a length > than 400" do
    race = races(:valid_race_two)
    race.length = 403
    refute race.valid?, "The race has been saved with a length > than 400"
    assert_not_empty race.errors[:length],'The race has not been saved with a length > than 400'
  end

  test "should not save race without length" do
    race = races(:valid_race_two)
    race.length = nil
    refute race.valid?, "The race has been saved without length"
    assert_not_empty race.errors[:length],'The race has not been saved without length'
  end

  test "should not save race with a non integer length" do
    race = races(:valid_race_two)
    race.length = 4.5
    refute race.valid?, "The race has been saved with a non integer length"
    assert_not_empty race.errors[:length],'The race has not been saved with a non integer length'
  end

  test "should not save race without elevation" do
    race = races(:valid_race_two)
    race.elevation = nil
    refute race.valid?, "The race has been saved without elevation"
    assert_not_empty race.errors[:elevation],'The race has not been saved without elevation'
  end

  test "should not save race with an elevation < than 0" do
    race = races(:valid_race_two)
    race.elevation = -50
    refute race.valid?, "The race has been saved with an elevation < than 0"
    assert_not_empty race.errors[:elevation],'The race has not been saved with an elevation < than 0'
  end

  test "should not save race with an elevation > than 35000" do
    race = races(:valid_race_two)
    race.elevation = 40000
    refute race.valid?, "The race has been saved with an elevation > than 35000"
    assert_not_empty race.errors[:elevation],'The race has not been saved with an elevation > than 35000'
  end

  test "should not save race with a non integer elevation" do
    race = races(:valid_race_two)
    race.elevation = 300.4
    refute race.valid?, "The race has been saved with a non integer elevation"
    assert_not_empty race.errors[:elevation],'The race has not been saved with a non integer elevation'
  end

  test "should not save race without a location" do
    race = races(:valid_race_two)
    race.location = ""
    refute race.valid?, "The race has been saved without a location"
    assert_not_empty race.errors[:location],'The race has not been saved without a location'
  end

  test "should not save race without a date" do
    race = races(:valid_race_two)
    race.date = ""
    refute race.valid?, "The race has been saved without a date"
    assert_not_empty race.errors[:date],'The race has not been saved without a date'
  end

  test "should not save race with a non correct date" do
    race = races(:valid_race_two)
    race.date = "I'm not a date"
    refute race.valid?, "The race has been saved with a non correct date"
    assert_not_empty race.errors[:date],'The race has not been saved with a non correct date'
  end

  test "should not save race with a date in the past" do
    race = races(:valid_race_two)
    race.date = Date.today - 1
    refute race.valid?, "The race has been saved with a date in the past"
    assert_not_empty race.errors[:date],'The race has not been saved with a date in the past'
  end

  test "should not save race without a departure time" do
    race = races(:valid_race_two)
    race.departure_time = nil
    refute race.valid?, "The race has been saved without a departure time"
    assert_not_empty race.errors[:departure_time],'The race has not been saved without a departure time'
  end

  test "should not save race without a description" do
    race = races(:valid_race_two)
    race.description = nil
    refute race.valid?, "The race has been saved without a description"
    assert_not_empty race.errors[:description],'The race has not been saved without a description'
  end

  test "should not save race with a short description" do
    race = races(:valid_race_two)
    race.description = "Hello"
    refute race.valid?, "The race has been saved with a short description"
    assert_not_empty race.errors[:description],'The race has not been saved with a short description'
  end

  test "should not save race without geolocation" do
    race = races(:valid_race_two)
    race.location = "Ajajananasksjskns"
    refute race.valid?, "The race has been saved without geolocation"
    assert_not_empty race.errors[:location],'The race has not been saved without geolocation'
  end

end

