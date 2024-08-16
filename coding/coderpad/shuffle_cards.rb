def shuffle_cards_method_1(cards)
  put_card_on_top = true
  shuffled_cards = []
  cards.each do |card|
    if put_card_on_top
      shuffled_cards.unshift(card)
    else
      shuffled_cards.push(card)
    end
    put_card_on_top = !put_card_on_top
  end
  shuffled_cards
end

def shuffle_cards_method_2(cards)
  cards_at_even_indexes = cards.values_at(* cards.each_index.select(&:even?))
  cards_at_odd_indexes = cards.values_at(* cards.each_index.select(&:odd?))
  cards_at_even_indexes.reverse + cards_at_odd_indexes
end

def main
  numeric_cards = (0..14).to_a
  shuffled_cards_1 = shuffle_cards_method_1(numeric_cards)
  shuffled_cards_2 = shuffle_cards_method_2(numeric_cards)
  puts shuffled_cards_1.inspect
  puts shuffled_cards_2.inspect
  raise "Shuffled cards don't match" unless shuffled_cards_1 == shuffled_cards_2

  card_values = %w[
    2 3 4 5 6 7 8 9 10
    Jack Queen King Ace
  ]
  card_colors = %w[Spades Hearts Clubs Diamonds]
  cards_pack = card_values.product(card_colors).map { |value, color| "#{value} of #{color}" }
  cards_pack.shuffle!
  shuffled_cards_pack_1 = shuffle_cards_method_1(cards_pack)
  shuffled_cards_pack_2 = shuffle_cards_method_2(cards_pack)
  raise "Shuffled card packs don't match" unless shuffled_cards_pack_1 == shuffled_cards_pack_2
end

main if __FILE__ == $PROGRAM_NAME
