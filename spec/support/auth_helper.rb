module AuthHelper
  def get_auth_token(owner)
    AuthenticationTokenService.call(owner.id)
  end
end
