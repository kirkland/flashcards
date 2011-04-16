function mark_for_destroy(a){$(a).next(".should_destroy").value=1;$(a).up(".card").hide()}function adjust_font(a){start_size=parseInt($("card_front_value").getStyle("font-size"));$("card_front_value").setStyle({fontSize:""+(start_size+a)+"px"});$("card_back_value").setStyle({fontSize:""+(start_size+a)+"px"})}Review=Class.create({initialize:function(b,a){this.cards=b;this.front_showing=true;this.active_card_index=0;if(a){$("quiz_card_content").observe("click",this.flip_card.bindAsEventListener(this))}else{$("quiz_card_content").observe("click",this.next_card.bindAsEventListener(this));$("quiz_card_content").observe("mouseover",this.flip_card_back.bindAsEventListener(this));$("quiz_card_content").observe("mouseout",this.flip_card_front.bindAsEventListener(this))}$("right_arrow").observe("click",this.next_card.bindAsEventListener(this));$("left_arrow").observe("click",this.prev_card.bindAsEventListener(this));this.refresh()},active_card:function(){return this.cards[this.active_card_index]},refresh:function(){$("quiz_card_content").update(this.front_showing?this.active_card().front:this.active_card().back);var a="audioUrl="+this.active_card().sound_url;if(a.match(/missing.png$/)||this.sound_url!=a){if(null!=$("sound_embed")){$("sound_embed").remove()}}if(!a.match(/missing.png$/)&&this.sound_url!=a){$("sound").insert({bottom:new Element("embed",{id:"sound_embed",height:"27",width:"400",src:"http://www.google.com/reader/ui/3523697345-audio-player.swf",pluginspage:"http://www.macromedia.com/go/getflashplayer",flashvars:a})})}this.sound_url=a},flip_card_front:function(){this.front_showing=true;this.refresh()},flip_card_back:function(){this.front_showing=false;this.refresh()},flip_card:function(){this.front_showing=!this.front_showing;this.refresh()},next_card:function(){if(this.active_card_index==this.cards.length-1){$("review_message").update("End of the deck!");$("review_message").show()}else{$("review_message").update("").hide();this.front_showing=this.front_showing=true;this.active_card_index+=1;this.refresh()}},prev_card:function(){if(this.active_card_index==0){$("review_message").update("Beginning of the deck!");$("review_message").show()}else{$("review_message").update("").hide();this.front_showing=this.front_showing=true;this.active_card_index-=1;this.refresh()}},});Quiz=Class.create({initialize:function(c,b,a){this.quiz_cards=c.quiz_cards;this.update_path=b;this.front_showing=true;this.active_card_index=this.find_active_card_index(c.active_card_id);if(a=="phone"){$("quiz_card_content").observe("click",this.flip_card.bindAsEventListener(this))}else{$("quiz_card_content").observe("mouseover",this.flip_card_back.bindAsEventListener(this));$("quiz_card_content").observe("mouseout",this.flip_card_front.bindAsEventListener(this))}$("right_arrow").observe("click",this.next_card.bindAsEventListener(this));$("left_arrow").observe("click",this.prev_card.bindAsEventListener(this));$("correct_link").observe("click",this.mark_correct.bindAsEventListener(this));$("incorrect_link").observe("click",this.mark_incorrect.bindAsEventListener(this));this.refresh();this.update_db({active_card_id:this.active_card().id})},find_active_card_index:function(b){if(null==b){return 0}var a=0;this.quiz_cards.each(function(d,c){if(b==d.id){a=c}}.bind(this));return a},active_card:function(){return this.quiz_cards[this.active_card_index]},refresh:function(){setTimeout(function(){$("quiz_card_content").update(this.front_showing?this.active_card().front:this.active_card().back);if(this.active_card().correct==true){$("correct_link").addClassName("selected");$("incorrect_link").removeClassName("selected")}else{if(this.active_card().correct==false){$("incorrect_link").addClassName("selected");$("correct_link").removeClassName("selected")}else{$("correct_link").removeClassName("selected");$("incorrect_link").removeClassName("selected")}}var a="audioUrl="+this.active_card().sound_url;if(a.match(/missing.png$/)||this.sound_url!=a){if(null!=$("sound_embed")){$("sound_embed").remove()}}if(!a.match(/missing.png$/)&&this.sound_url!=a){$("sound").insert({bottom:new Element("embed",{id:"sound_embed",height:"27",width:"400",src:"http://www.google.com/reader/ui/3523697345-audio-player.swf",pluginspage:"http://www.macromedia.com/go/getflashplayer",flashvars:a})})}this.sound_url=a}.bind(this),500)},update_db:function(a){if(a==null){a=new Object()}a.active_card_id=this.active_card().id;new Ajax.Request(this.update_path,{parameters:a,onSuccess:function(b){this.quiz_status=b.responseJSON;if(quiz_status.error!=undefined&&$("flash-error")==undefined){$("quiz").insert({top:new Element("div",{id:"flash-error"}).insert(new Element("ul").insert(new Element("li").update(quiz_status.error)))})}$("cards_correct").update(this.quiz_status.num_correct);$("cards_answered").update(this.quiz_status.num_answered);$("cards_remaining").update(this.quiz_status.num_remaining)}})},flip_card_front:function(){this.front_showing=true;this.refresh()},flip_card_back:function(){this.front_showing=false;this.refresh()},flip_card:function(){this.front_showing=!this.front_showing;this.refresh()},next_card:function(){if(this.active_card_index==this.quiz_cards.length-1){$("review_message").update("End of the deck!");$("review_message").show()}else{$("review_message").update("").hide();this.front_showing=true;this.active_card_index+=1;this.refresh();this.update_db()}},prev_card:function(){if(this.active_card_index==0){$("review_message").update("Beginning of the deck!");$("review_message").show()}else{$("review_message").update("").hide();this.front_showing=true;this.active_card_index-=1;this.refresh();this.update_db()}},mark_correct:function(){this.active_card().correct=true;var a=this.active_card().id;if(this.active_card().correct==true){$("correct_link").addClassName("selected");$("incorrect_link").removeClassName("selected")}else{if(this.active_card().correct==false){$("incorrect_link").addClassName("selected");$("correct_link").removeClassName("selected")}else{$("correct_link").removeClassName("selected");$("incorrect_link").removeClassName("selected")}}if(this.active_card_index==this.quiz_cards.length-1){$("review_message").update("End of the deck!");$("review_message").show()}else{this.front_showing=true;this.active_card_index+=1;this.refresh()}this.update_db({correct_card:a})},mark_incorrect:function(){this.active_card().correct=false;if(this.active_card().correct==true){$("correct_link").addClassName("selected");$("incorrect_link").removeClassName("selected")}else{if(this.active_card().correct==false){$("incorrect_link").addClassName("selected");$("correct_link").removeClassName("selected")}else{$("correct_link").removeClassName("selected");$("incorrect_link").removeClassName("selected")}}var a=this.active_card().id;if(this.active_card_index==this.quiz_cards.length-1){$("review_message").update("End of the deck!");$("review_message").show()}else{this.front_showing=true;this.active_card_index+=1;this.refresh()}this.update_db({incorrect_card:a})},});