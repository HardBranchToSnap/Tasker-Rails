class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    #@message = current_user.messages.new(message_params)
    @project = Project.find(params[:project_id])
    @message = @project.messages.create(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        #redirect_to projects_path, notice: 'Message added'
        format.js
      else
        #redirect_to projects_path, notice: 'Not added'
        format.js
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
      @message.destroy
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
  end

  private

  def message_params
    params.require(:message).permit(:body, :project_id)
  end
end