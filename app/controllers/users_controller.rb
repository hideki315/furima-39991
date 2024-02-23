class UsersController < ApplicationController
  def new
    @user = Users.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :encrypted_password, :first_name, :last_name,
                                 :katakana_first_name, :katakana_last_name, :birth_day)
  end
end
