module ApplicationCable
  # 接続しているユーザー ≒ current_user を定義する
  class Connection < ActionCable::Connection::Base
   identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
  def find_verified_user
  #(current_user = env['warden'].user) ? current_user : reject_unauthorized_connection
        verified_id = 1
        session_key = cookies.encrypted[Rails.application.config.session_options[:key]]
        if session_key['warden.user.user.key']
        verified_id = session_key['warden.user.user.key'][0][0]
        end
        verified_user = User.find_by(id: verified_id)
        return reject_unauthorized_connection unless verified_user
        verified_user
  end
  end
end
