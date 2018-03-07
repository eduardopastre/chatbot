module UserModule
  class CreateService
    def initialize(params)
      @username = params["username-original"]
    end

    def call
      return 'username obrigatório' if @username.nil?
      begin
        user = User.new(username: @username)
        if user.save
          'Criado com sucesso'
        else
          user.errors.full_messages[0]
        end
      rescue => e
        'Erro na criação de usuário '+e
      end
    end
  end  
end