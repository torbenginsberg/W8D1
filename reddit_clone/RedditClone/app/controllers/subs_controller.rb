class SubsController < ApplicationController
    before_action :require_logged_in, except: [:index, :show]

    def new
        @sub = Sub.new 
        render :new 
    end

    def create 
        @sub = Sub.new(sub_params)
        @sub.user_id = params[:user_id]
        if @sub.save
            redirect_to subs_url 
        else
            flash[:errors] = @sub.errors.full_messages
            flash.now[:errors]
            render :new 
        end
    end

    def show 
        @sub = Sub.find(params[:id])
        render :show 
    end

    def index 
        @subs = Sub.all 
        render :index 
    end

    def destroy 
        @sub = Sub.find(params[:id])
        if @sub && @sub.delete 
            redirect_to subs_url 
        end
    end

    def edit 
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update 
        # @sub = Sub.moderator.subs.find_by(id: params[:id])
        @sub = Sub.find(params[:id])
        if @sub && @sub.update(sub_params) && @sub.user_id == current_user.id 
            redirect_to sub_url(@sub)
        else
            flash[:errors] = ["Permission denied"]
            flash.now[:errors]
            redirect_to subs_url 
        end
    end

    private 
    def sub_params 
        params.require(:sub).permit(:title, :description)
    end
end
