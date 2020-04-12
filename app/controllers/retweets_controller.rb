class RetweetsController < ApplicationController
    
  def create
    @school = School.find(params[:school_id])
    current_user.retweet(@school)
    @school.update_attribute(:updated_at, Time.zone.now)
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
  end
  
  def destroy
    @school = Retweet.find(params[:id]).school
    current_user.unretweet(@school)
    @school.update_attribute(:updated_at, Time.zone.now)
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
  end
end
