require 'rails_helper'

FactoryBot.define do
  factory :user do
    nick_name              { 'test' }
    email                  { 'test@example.com' }
    password               { 'password123' }
    password_confirmation  { 'password123' }
    first_name             { 'John' }
    last_name              { 'Doe' }
    katakana_first_name    { 'ジョン' }
    katakana_last_name     { 'ドー' }
    birth_day              { Date.new(1990, 1, 1) }
  end
end
