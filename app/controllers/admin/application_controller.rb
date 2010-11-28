class Admin::ApplicationController < ApplicationController
  before_filter :admin_user?

  private

  def admin_user?
    return true if current_user && current_user.admin?
    flash[:error] = "Not authorized."
    redirect_to root_url and return
  end
end
