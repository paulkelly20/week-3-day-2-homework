require("pry-byebug")
require_relative("./models/bounty_hunter.rb")

bounty1 = SpaceCowboy.new({
    "name" => "Mike",
    "species" => "Martian",
    "bounty_value" => 1000,
    "homeworld" => "Mars"
})

bounty1.save()

bounty2 = SpaceCowboy.new({
  "name" => "Jimmy",
  "species" => "Jupes",
  "bounty_value" => 1000000,
  "homeworld" => "Jupiter"
  })

bounty2.save()

binding.pry
nil
