class SchoolRelationshipsController < ApplicationController
  before_action :logged_in_user
    
  def create
    @school = School.find(params[:school_id])
    current_user.enter(@school)
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
  end
  
  def destroy
    @school = SchoolRelationship.find(params[:id]).school
    current_user.graduate(@school)
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
  end
end
