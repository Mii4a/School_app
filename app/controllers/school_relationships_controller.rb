class SchoolRelationshipsController < ApplicationController
  before_action :logged_in_user
    
  def create
    @school = School.find(params[:school_id])
    current_user.enter(@school)
    redirect_to @school
  end
  
  def destroy
    @school = SchoolRelationship.find(params[:id]).school
    current_user.graduate(@school)
    redirect_to @school
  end
end
