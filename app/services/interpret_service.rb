class InterpretService
  def self.call action, params
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params, action).call
    when "create"
      FaqModule::CreateService.new(params).call
    when "remove"
      FaqModule::RemoveService.new(params).call
    when "help"
      HelpService.call
    when "create_user"
      UserModule::CreateService.new(params).call
    when "favorites"
      UserFaqModule::ListService.new(params).call
    when "add_favorite"
      UserFaqModule::CreateService.new(params).call
    when "remove_favorte"
      UserFaqModule::RemoveService.new(params).call
    else
      "Não compreendi o seu desejo"
    end
  end
end