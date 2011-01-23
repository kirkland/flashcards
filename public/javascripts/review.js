Review = Class.create({
  initialize: function(cards, show_side) {
    this.cards = cards;
    this.show_side = show_side;
    this.front_showing = show_side != "back";
    this.active_card_index = 1;

    if (this.front_showing == true) {
      $('quiz_card').observe('mouseover', this.flip_card_back.bindAsEventListener(this));
      $('quiz_card').observe('mouseout', this.flip_card_front.bindAsEventListener(this));
    } else {
      $('quiz_card').observe('mouseover', this.flip_card_front.bindAsEventListener(this));
      $('quiz_card').observe('mouseout', this.flip_card_back.bindAsEventListener(this));
    }

    $('right_arrow').observe('click', this.next_card.bindAsEventListener(this));
    $('left_arrow').observe('click', this.prev_card.bindAsEventListener(this));

    this.refresh();
  },

  active_card: function() {
    return this.cards[this.active_card_index];
  },

  refresh: function() {
    $('quiz_card_content').update(this.front_showing ? this.active_card().front : this.active_card().back);

    var new_url = 'audioUrl=' + this.active_card().sound_url;
    if (new_url.match(/missing.png$/) || this.sound_url != new_url) {
      if (null != $('sound_embed')) {
        $('sound_embed').remove();
      }
    }

    if (!new_url.match(/missing.png$/) && this.sound_url != new_url) {
      $('sound').insert({bottom: new Element('embed', {id: 'sound_embed', height: "27", width: "400", src: "http://www.google.com/reader/ui/3523697345-audio-player.swf", pluginspage: "http://www.macromedia.com/go/getflashplayer", flashvars: new_url})});
    }

    this.sound_url = new_url;
  },

  flip_card_front: function() {
    this.front_showing = true;
    this.refresh();
  },

  flip_card_back: function() {
    this.front_showing = false;
    this.refresh();
  },

  next_card: function () {
    if (this.active_card_index == this.cards.length - 1) {
      alert("End of the deck!");
    } else {
      this.front_showing = this.show_side == "front";
      this.active_card_index += 1;
      this.refresh();
    }
  },

  prev_card: function () {
    if (this.active_card_index == 0) {
      alert("Beginning of deck!");
    } else {
      this.front_showing = this.show_side == "front";
      this.active_card_index -= 1;
      this.refresh();
    }
  },
});
