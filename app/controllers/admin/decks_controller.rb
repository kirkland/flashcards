class Admin::DecksController < Admin::ApplicationController
  before_filter :find_deck, :only => [:edit, :show, :update, :destroy, :activate, :deactivate]
  def index
    @decks = Deck.all
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deck }
    end
  end

  def new
    @deck = Deck.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deck }
    end
  end

  def edit
  end

  def create
    @deck = Deck.new(params[:deck])

    respond_to do |format|
      if @deck.save
        format.html { redirect_to(admin_deck_url(@deck), :notice => 'Deck was successfully created.') }
        format.xml  { render :xml => @deck, :status => :created, :location => @deck }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deck.update_attributes(params[:deck])
        format.html { redirect_to(:action => 'show', :notice => 'Deck was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to(admin_decks_url) }
      format.xml  { head :ok }
    end
  end

  def activate
    @deck.update_attribute(:active, true)
    redirect_to admin_decks_path
  end

  def deactivate
    @deck.update_attribute(:active, false)
    redirect_to admin_decks_path
  end

  private

  def find_deck
    @deck = Deck.find(params[:id])
  end
end
