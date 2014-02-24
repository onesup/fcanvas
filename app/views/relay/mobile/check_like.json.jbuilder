user = MantoUser.find_by_uid(params[:uid])
page_id = FACEBOOK_CONFIG[:relay][:page_id]
token = user.token
api = Koala::Facebook::API.new(token)
result = false
begin
  query = api.get_connections("me","likes/" + page_id)
  result = true unless query.empty?
  info = "true"
rescue Koala::Facebook::AuthenticationError
  Rails.logger.info "auth error!! uid: " + user.uid
  session[:facebook_uid] = nil
  result = false
  info = "auth error"
rescue Koala::Facebook::ClientError
  Rails.logger.info "client error!! uid: " + user.uid
  session[:facebook_uid] = nil
  result = false
  info = "client error"
end
Rails.logger.info "@@@@@check_like: "+ result.to_s

json.result result