class Deck < ActiveRecord::Base
  has_many :cards
  has_many :quizzes
  has_many :hidden_decks

  after_update :save_cards

  validates_associated :cards
  validates_presence_of :front_description
  validates_presence_of :back_description

  validates_format_of :bulk_cards, :with => /\A(.+\|.+\n?){1,}\z/, :on => :create
          
  def bulk_cards
    @bulk_cards || ""
  end

  def bulk_cards=(text)
    @bulk_cards ||= text
    new_cards = text.split("\n")
    new_cards.each do |card|
      front, back = card.split("|")
      back.try(:sub!, /\r/, "")
      cards.build(:deck => self, :front => front, :back => back)
    end
  end

  def card_attributes=(card_attributes)
    card_attributes.each do |attributes|
      if attributes[:id].blank?
        cards.build(attributes)
      else
        card = cards.detect {|t| t.id == attributes[:id].to_i }
        card.attributes = attributes
      end
    end
  end

  def save_cards
    cards.each do |c|
      if c.should_destroy?
        c.destroy
      else
        c.save(:validate => false)
      end
    end
  end

  def review_data(show_back=false)
    cards.collect do |c|
      {
        :front => show_back ? c.back : c.front,
        :back => show_back ? c.front : c.back,
        :sound_url => c.sound.url
      }
    end.shuffle
  end

  # eh, just look at first card, and assume a deck either has all sounds or no sounds
  def has_sound?
    cards.first.sound_file_name.present?
  end

  def quiz_results(user, back_to_front)
    quizzes.where(:back_to_front => back_to_front).where(:user_id => user.id).order('created_at DESC').limit(3).collect(&:results).reverse
  end

  def hidden?(user)
    HiddenDeck.where(:deck_id => id, :user_id => user.id).present?
  end

  def hide!(user)
    HiddenDeck.find_or_create_by_user_id_and_deck_id(user.id, id)
  end

  def unhide!(user)
    hd = HiddenDeck.find_by_user_id_and_deck_id(user.id, id)
    hd.destroy if hd.present?
  end

  class << self
    # aha, thank you stack overflow: http://stackoverflow.com/questions/3875564/how-to-use-rails-3-scope-to-filter-on-habtm-join-table-where-the-associated-recor
    def not_hidden(user)
      joins('left outer join hidden_decks on decks.id = hidden_decks.deck_id').where('hidden_decks.deck_id is null')
    end

    def active
      where(:active => true)
    end
  end
end
