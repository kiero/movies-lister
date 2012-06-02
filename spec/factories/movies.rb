# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "MyString"
    cast "MyText"
    director "MyString"
    release "2012-06-02"
    duration 1
    genre "MyString"
    rate 1
  end
end
