FactoryBot.define do
  factory :user do
    sequence :nick_name do |n|
      "user#{n}"
    end

    sequence :email do |n|
      Faker::Internet.email.sub('@', "#{n}@")
    end

    password { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: false) }
    password_confirmation { password }
    first_name { '山田' }
    last_name { '太郎' }
    katakana_first_name { 'ヤマダ' }
    katakana_last_name { 'タロウ' }
    birth_day { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
