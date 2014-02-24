user = MantoUser.find_by_uid(params[:uid])
result = user.check_like
Rails.logger.info "@@@@@check_like.json"

json.result result