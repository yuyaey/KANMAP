class TestsessionsController < ApplicationController
  skip_before_action :login_required

  def create
    user=User.find_by(email:"testuser@example.com")
    session[:user_id] = user.id
    flash[:success] = "テストユーザとしてログインしました。"
    redirect_to root_url
  end
end
