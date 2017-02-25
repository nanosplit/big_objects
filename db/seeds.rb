10000.times do
  User.create
end

user_ids = User.pluck(:id)

100000.times do
  Invoice.create(
      user_id: user_ids.sample,
      total: Faker::Number.number(6)
    )
end
