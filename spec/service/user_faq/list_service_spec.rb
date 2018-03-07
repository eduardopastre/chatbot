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

    context "With favorites faq" do
      before(:each) do
        create(:user_faq, user: @user, faq: @faq1)
      end

      it "Find question and answer with one favorite" do
        list_service = UserFaqModule::ListService.new({'original-username' => @user.username})
        response = list_service.call()
        expect(response).to match(@faq1.question)
        expect(response).to match(@faq1.answer)
      end

      it "Find question and answer with two favorites" do
        create(:user_faq, user: @user, faq: @faq2)
        list_service = UserFaqModule::ListService.new({'original-username' => @user.username})
        response = list_service.call()
        expect(response).to match(@faq1.question)
        expect(response).to match(@faq1.answer)

        expect(response).to match(@faq2.question)
        expect(response).to match(@faq2.answer)
      end
    end
  end
end