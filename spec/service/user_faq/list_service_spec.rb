require_relative './../../spec_helper.rb'

describe UserFaqModule::ListService do
  describe "#call" do
    before(:each) do
      @user = create(:user)
      @faq1 = create(:faq)
      @faq2 = create(:faq)
      @faq3 = create(:faq)
    end
    it "Without param username, receive username required" do
      list_service = UserFaqModule::ListService.new({})
      response = list_service.call()
      expect(response).to match('Usuário não encontrado')
    end

    it "With invalid username, receive user not found" do
      username = FFaker::Name.first_name
      list_service = UserFaqModule::ListService.new({'original-username' => username})
      response = list_service.call()
      expect(response).to match('Usuário não encontrado')
    end

    it "Without favorite faq, receive not find favorites" do
      list_service = UserFaqModule::ListService.new({'original-username' => @user.username})
      response = list_service.call()
      expect(response).to match('Nenhum favorito encontrado')
    end

    it "With one favorite, receive list of faqs" do
      create(:user_faq, user: @user, faq: @faq1)
      list_service = UserFaqModule::ListService.new({'original-username' => @user.username})
      response = list_service.call()
      expect(response.length).to eq(1)
    end

    it "With two or more favorite, receive list of faqs" do
      create(:user_faq, user: @user, faq: @faq1)
      create(:user_faq, user: @user, faq: @faq2)
      list_service = UserFaqModule::ListService.new({'original-username' => @user.username})
      response = list_service.call()
      expect(response.length).to eq(2)
    end
  end
end