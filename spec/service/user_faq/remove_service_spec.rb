require_relative './../../spec_helper.rb'

describe UserFaqModule::RemoveService do
  describe "#call" do
    before(:each) do
      @faq1 = create(:faq)
      @user = create(:user)
      create(:user_faq, faq: @faq1, user: @user)
    end
    it "Without username, receive username required" do
      remove_service = UserFaqModule::RemoveService.new({'original-faq' => @faq1.id})
      response = remove_service.call
      expect(response).to match('Username não encontrado')
    end

    it "Without faq_id, receive faq required" do
      remove_service = UserFaqModule::RemoveService.new({'original-username' => @user.username})
      response = remove_service.call
      expect(response).to match('Faq não encontrada')
    end

    it "Whit invalid username, receive username not found" do
      username = FFaker::Name.first_name
      remove_service = UserFaqModule::RemoveService.new({'original-username' => username, 'original-faq' => 100})
      response = remove_service.call
      expect(response).to match('Username não encontrado')
    end

    it "Whit invalid faq, receive favorite not found" do
      remove_service = UserFaqModule::RemoveService.new({'original-username' => @user.username, 'original-faq' => 100})
      response = remove_service.call
      expect(response).to match('Favorito não encontrado')
    end

    it "Remove from favorites, receive success message" do
      remove_service = UserFaqModule::RemoveService.new({'original-username' => @user.username, 'original-faq' => @faq1.id})
      response = remove_service.call
      expect(response).to match('Favorito removido com sucesso')
    end

    it "Remove from favorites, update database" do
      remove_service = UserFaqModule::RemoveService.new({'original-username' => @user.username, 'original-faq' => @faq1.id})
      user_faqs = UserFaq.count
      response = remove_service.call
      expect(UserFaq.count).to eq(user_faqs - 1)
    end
  end
end