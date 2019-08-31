def login_user(user = nil)
  user ||= create(:user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end

def logout_user
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
end
