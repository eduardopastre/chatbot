module UserFaqModule
  class RemoveService
    def initialize(params)
      @user = User.find_by_username(params['username'])
      @faq_id = params['faq']
    end

    def call
      return 'Username não encontrado' if @user.nil?
      return 'Informe o id faq' if @faq_id.nil?

      begin
        user_faq = UserFaq.find_by_user_id_and_faq_id(@user.id, @faq_id)
        if !user_faq.nil?
          user_faq.delete
          'Favorito removido com sucesso'
        else
          'Favorito não encontrado'
        end
      rescue
        'Falha ao tentar remover favorito'
      end
    end
  end
end