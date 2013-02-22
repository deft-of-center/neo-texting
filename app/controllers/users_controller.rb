class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    legit_user?
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { 
          sign_in @user
          redirect_to @user, notice: 'Welcome to neotext!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    legit_user?

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    legit_user?
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followed_users
    @title = "The Following"
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    @title = "The Followed"
    render 'show_follow'
  end

  private

    def legit_user?
      unless current_user ==  @user
        redirect_to @user, notice: "Homey don't play that."
      end
    end
end
