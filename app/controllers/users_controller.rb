class UsersController < SignedInController
  before_filter :check_admin

  expose(:users)
  expose(:user, attributes: :user_params)

  def create
    if user.save
      redirect_to user
    else
      flash[:error] = "Could not save user"

      redirect_to action: 'index'
    end
  end

  def update
    if user_params[:password].presence
      if user.save
        redirect_to user
      else
        render :edit
      end
    else
      user = User.find(params[:id])
      params_without_password = 
        user_params.reject { |k, v| 
          k == 'password' or k == 'password_confirmation' 
        }

      if user.update_attributes(params_without_password)
        redirect_to user
      else
        render :edit
      end
    end
  end

  def destroy
    user.delete
    redirect_to action: 'index'
  end

  def update_password
    @user = User.find(params[:id])
    if current_user.valid_password?(params[:user][:current_password])
      @user.update_attributes(user_params)
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def check_admin
    unless current_user.admin
      redirect_to root_path
    end
  end

end