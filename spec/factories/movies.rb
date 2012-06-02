# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "Movie title"
    cast "Sidney Lumet, Reginald Rose, Henry Fonda, George Justin"
    director "Steven Spielberg"
    release "2012-06-02"
    duration 115
    genre "Crime, Drama, Mystery"
    rate 5
  end
end
