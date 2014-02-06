class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    if @current_user
      @list = @current_user.lists.create(list_params)
      if @list.save 
        redirect_to list_path(@list.id), notice: "Your list was created!"
      else
        render "new"
      end
    else
      redirect_to new_user_path, notice: "You must be logged in to do that"
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to @list, notice: "List has been updated"
    else
      render :edit
    end
  end

  def show
    @list = List.find(params[:id].to_i)
    @item = Item.new
  end

  def edit
    @list = List.find(params[:id].to_i)
  end
  
  private
  def list_params
    params.require(:list).permit(:title, :user_id)
  end
end