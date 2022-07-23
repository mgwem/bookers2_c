class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
    @owner = User.find(@group.owner_id)
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
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "グループを更新しました"
    else
      render :edit
    end
  end

  def join_group
    @group_user = GroupUser.new
    @group = Group.find(params[:group_id])
    @group_user.group_id = @group.id
    @group_user.user_id = current_user.id
    @group_user.save
    redirect_to groups_path
  end

  def leave_group
    @group = Group.find(params[:group_id])
    group_user = current_user.group_users.find_by(group_id: @group.id)
    group_user.destroy
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def mail_event
    @group = Group.find(params[:group_id])
    @group_users = @group.users
    @group_name = @group.name
    @title = params[:title]
    @content = params[:content]
    GroupMailer.notice_event(@title, @content, @group_users, @group_name).deliver
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
