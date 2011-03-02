Factory.define :deck do |f|
  d.title "A Test Deck"
  d.front_description "The front description"
  d.back_description "The back description"
  d.active true
end

Factory.define :card do |f|
  c.front "front of card"
  c.back "back of card"
end
