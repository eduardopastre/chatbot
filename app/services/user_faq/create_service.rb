module UserFaqModule
  class CreateService
    def initialize(params)
      @user = User.find_by_username(params['username'])
      @faq = Faq.find(params['faq']) rescue nil
    end

    def call
      return 'usuário não encontrado' if @user.nil?
      return 'faq não encontrada' if @faq.nil?

      begin
        if UserFaq.create(user_id: @user.id, faq_id: @faq.id)
          'Adicionado com sucesso'
        else
          'Erro ao favoritar faq'
        end
      rescue => e
        puts e
        'Erro ao favoritar faq '+e
      end
    end
  end  
end