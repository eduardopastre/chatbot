module UserFaqModule
  class ListService
    def initialize(params)
      @user = User.find_by_username(params['original-username'])
    end

    def call
      return 'Usuário não encontrado' if @user.nil?

      begin
        return 'Nenhum favorito encontrado' if @user.faqs.length == 0

        @user.faqs
      rescue
        'Falha ao listar favoritos'
      end
    end
  end  
end