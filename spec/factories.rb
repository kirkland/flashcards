Factory.define :deck do |f|
  f.title "A Test Deck"
  f.front_description "The front description"
  f.back_description "The back description"
  f.active true
  f.bulk_cards "front of bulk card|back of bulk card"
end

Factory.define :card do |f|
  f.front "front of card"
  f.back "back of card"
end
