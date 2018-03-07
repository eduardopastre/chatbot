module UserFaqModule
  class CreateService
    def initialize(params)
      @user = User.find_by_username(params['original-username'])
      @faq = Faq.find(params['original-faq']) rescue nil
    end

    def call
      return 'usuário não encontrado' if @user.nil?
      return 'faq não encontrada' if @faq.nil?

      begin
        if @user.faqs.build({id: @faq.id})
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