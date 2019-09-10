Fabricator(:user) do
  password = FFaker::Internet.password
  email { FFaker::Internet.email }
  password password
  password_confirmation password
end
