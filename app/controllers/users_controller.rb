class UsersController < ApplicationController
  before_filter :find_user
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."  
      redirect_to root_url  
    else  
      flash[:error] = @user.errors
      render :action => 'new'  
    end  
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      flash[:error] = @user.errors
      render :action => 'edit'
    end
  end

  def profile
    @quizzes = @user.quizzes.sort_by(&:created_at).reverse
  end

  def quiz_details
    @quizzes = @user.quizzes.where(:deck_id => params[:deck_id], :back_to_front => params[:back_to_front].present?).sort_by(&:created_at).reverse
    render :profile
  end

  private

  def find_user
    @user = current_user
  end
end
