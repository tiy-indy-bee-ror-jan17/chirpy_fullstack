class ChirpsController < ApplicationController

  before_action :require_user, only: [:new, :create, :destroy]
  before_action :is_owner, only: [:destroy]

  def index
    @chirps = Chirp.page(params[:page])
  end

  def show
    @chirp = Chirp.find(params[:id])
  end

  def new
    @chirp = Chirp.new
  end

  def create
    @chirp = current_user.chirps.new(chirp_params)
    if @chirp.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    @chirp.destroy
    redirect_to :root
  end

  def shares
    @chirp = Chirp.find(params[:id])
  end

  def sender
    @chirp = Chirp.find(params[:id])
    if params[:share][:email].blank?
      flash[:warning] = "You need to supply an email address to share with"
      render :shares
    else
      UserMailer.share(@chirp, params[:share][:email]).deliver
      flash[:success] = "That thing is _shared_, yo."
      redirect_to @chirp # chirp_path(@chirp)
    end
  end

  private

  def chirp_params
    # {chirp: {user_id: , body:}}
    params.require(:chirp).permit(:body, :photo)
  end

  def is_owner
    @chirp = current_user.chirps.find_by(id: params[:id])
    unless @chirp && @chirp.user == current_user
      flash[:danger] = "That's not your chirp, bucky"
      redirect_to :root
    end
  end

end
