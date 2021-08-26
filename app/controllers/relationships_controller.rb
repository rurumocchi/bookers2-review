class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @follow = current_user.active_relationships.new(follower_id: @user.id)
    @follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    @follow = current_user.active_relationships.find_by(follower_id: @user.id)
    @follow.destroy
    redirect_back(fallback_location: root_path)
  end

end
