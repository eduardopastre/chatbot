module UserFaqModule
  class ListService
    def initialize(params)
      @user = User.find_by_username(params['original-username'])
    end

    def call
      return 'Usuário não encontrado' if @user.nil?
      begin
        response = "*Perguntas e Respostas* \n\n"
        @user.faqs.each do |f|
          response += "*#{f.id}* - "
          response += "*#{f.question}*\n"
          response += ">#{f.answer}\n"
          f.hashtags.each do |h|
            response += "_##{h.name}_ "
          end
          response += "\n\n"
        end
        (@user.faqs.count > 0) ? response : 'Nenhum favorito encontrado'
      rescue
        'Falha ao listar favoritos'
      end
    end
  end  
end