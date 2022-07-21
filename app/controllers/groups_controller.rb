class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end

end
