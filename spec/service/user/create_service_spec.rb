require_relative './../../spec_helper.rb'

describe UserModule::CreateService do
  before do
    #@user = create(:user)
    
  end

  describe '#call' do
    it 'Without username params, receive an error' do
      create_service = UserModule::CreateService.new({})
      response = create_service.call()
      expect(response).to match('username obrigatório')
    end

    it 'With valida params, receive success' do
      username = FFaker::Name.first_name
      create_service = UserModule::CreateService.new({'username-original' => username})
      response = create_service.call()
      expect(response).to match('Criado com sucesso')
    end

    it 'With existent username, receive username already exists' do
      @user = create(:user)
      @user.save
      puts @user
      create_service = UserModule::CreateService.new({'username-original' => @user.username})
      response = create_service.call()
      puts response
      expect(response).to match('Username já existe')
    end
  end
end