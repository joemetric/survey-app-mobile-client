class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(params[:answer])
    success = @answer && @answer.save
    status  = success && @answer.errors.empty?
    
    respond_to do |format|
      format.json {
        if status
          render :json => @answer
        else
          render :json => @answer.errors, :status => :unprocessable_entity
        end
      }
    end
  end
end