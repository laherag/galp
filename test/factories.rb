FactoryGirl.define do
  sequence :firstname do |n|
    "firstname#{n}"
  end

  sequence :lastname do |n|
    "firstname#{n}"
  end

  sequence :cups do |n|
    "#{n}#{n}#{n}#{n}#{n}#{n}#{n}#{n}#{n}#{n}"
  end

  factory :contract do
    firstname
    lastname
    cups
    status "ok"
    tipo "gaz"
    work "no"
  end

end