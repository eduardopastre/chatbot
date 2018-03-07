require_relative './../../spec_helper.rb'

describe UserFaqModule::CreateService do

  describe "#call" do
    before(:each) do
      @faq = create(:faq)
      @user = create(:user)
    end
    it "Without param username, return user not found" do
      create_service = UserFaqModule::CreateService.new({'original-faq' => @faq.id})
      response = create_service.call()
      expect(response).to match('usuário não encontrado')
    end

    it "Without param faq, return faq not found" do
      create_service = UserFaqModule::CreateService.new({'original-username' => @user.username})
      response = create_service.call()
      expect(response).to match('faq não encontrada')
    end

    it "With nonexistent user, return user not found" do
      username = FFaker::Name.first_name
      create_service = UserFaqModule::CreateService.new({'original-username' => username, 
        'original-faq' => @faq.id})
      response = create_service.call()
      expect(response).to match('usuário não encontrado')
    end

    it "With nonexistent faq, return faq not found" do
      create_service = UserFaqModule::CreateService.new({'original-username' => @user.username, 
        'original-faq' => 100})
      response = create_service.call()
      expect(response).to match('faq não encontrada')
    end

    it "With valid user and faq, receive success" do
      create_service = UserFaqModule::CreateService.new({'original-username' => @user.username, 
        'original-faq' => @faq.id})
      response = create_service.call()
      expect(response).to match('Adicionado com sucesso')
    end
  end
end