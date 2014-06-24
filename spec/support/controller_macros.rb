module ControllerMacros
  def login_admin
    before :each do
      @request.env['devise.mappings'] = Devise.mappings[:admin]
      @admin = Admin.find_by(id: 1) || FactoryGirl.create(:admin)
      sign_in @admin
    end

    after :each do
      sign_out @admin
    end
  end

  def login_user
    before :each do
      @request.env['devise.mappings'] = Devise.mappings[:user]
      @user = User.find_by(id: 1) || FactoryGirl.create(:user1)
      sign_in @user
    end

    after :each do
      sign_out @user
    end
  end
end
