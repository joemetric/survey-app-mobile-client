class CompletionsController < ApplicationController
  def create
    @completion = current_user.completions.new(params[:completion])
    success = @completion && @completion.save
    status  = success && @completion.errors.empty?
    
    respond_to do |format|
      format.json {
        if status
          render :json => @completion
        else
          render :json => @completion.errors, :status => :unprocessable_entity
        end
      }
    end
  end
end
