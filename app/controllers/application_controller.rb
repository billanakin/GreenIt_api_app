class ApplicationController < ActionController::API
  include ActiveStorage::SetCurrent
  include Pagy::Backend

  protected

  def current_user_auth_token
    @current_auth_token ||=
      begin
        header = request.headers['Authorization']
        
        return if header.nil?

        header.split&.last&.strip
      end
  end

  def current_user_id
    @current_user_id ||=
      begin
        if current_user_auth_token.present?
          payload = JwtToken.decode(current_user_auth_token)
          payload[:user_id]
        end
      end
  end

  def current_user
    @current_user ||=
      begin
        if current_user_id.present? && User.exists?(current_user_id)
          User.find(current_user_id)
        end
      end
  end

  def authenticate_user!
    return if current_user.present?

    render json: { message: "Unauthorized access" }, status: :unauthorized
  end
end
