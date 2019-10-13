require 'rails_helper'

RSpec.describe KanzumesController, type: :controller do

  let(:user) { FactoryBot.build(:user) }

  def login(user)
    allow(controller)
    .to receive(:current_user)
    .and_return(user)
  end

  describe "#index" do
    context "as a logined user" do
      before do
        login(user)
      end

      it "responds successfully" do
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest user" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to log-in page" do
        get :index
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#show" do
    context "as a logined user" do
      before do
        login(user)
        @kanzume = FactoryBot.create(:kanzume, user: user)
      end

      it "responds successfully" do
        get :show, params: {id: @kanzume.id}
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#create" do
    context "as a loggined user" do
      before do
        other_user = FactoryBot.create(:user)
        kanzume_icon = FactoryBot.create(:kanzume_icon, id: 99)
        map = FactoryBot.create(:map, id: 99)
      end
        context "with valid attributes" do
          it "add a kanzume" do
            login(user)
          @kanzume_params = FactoryBot.attributes_for(:kanzume, :forpost, user: user)
            expect {
              post :create, params: { kanzume: @kanzume_params}
            }.to change(user.kanzumes, :count).by(1)
          end
        end

        context "with invalid attributes" do
          it "does not add a kanzume" do
            kanzume_params = FactoryBot.attributes_for(:kanzume, :invalid)
            login(user)
              expect {
                post :create, params: { kanzume: kanzume_params }
              }.to_not change(user.kanzumes, :count)
          end
        end
    end

    context "as a guest" do
      it "returns a 302 response" do
        kanzume_params = FactoryBot.attributes_for(:kanzume) 
        post :create, params: {kanzume: kanzume_params}
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        kanzume_params = FactoryBot.attributes_for(:kanzume) 
        post :create, params: {kanzume: kanzume_params}
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#update" do
    context "as a loggined user" do
      before do
        login(user)
        @kanzume = FactoryBot.create(:kanzume, user: user)
      end
      context "with valid attributes" do
        it "updates a kanzume" do
          kanzume_params = FactoryBot.attributes_for(:kanzume, name: "New Kanzume Name")
          patch :update, params: { id: @kanzume.id, kanzume: kanzume_params }
          expect(@kanzume.reload.name).to eq "New Kanzume Name"
        end
      end

      context "with invalid attributes" do
        it "does not update a kanzume" do
          kanzume_params = FactoryBot.attributes_for(:kanzume, :invalid)
          patch :update, params: { id: @kanzume.id, kanzume: kanzume_params }
          expect(@kanzume.reload.name).not_to eq true
        end
      end
    end

    context "as a guest" do
      before do
        @kanzume = FactoryBot.create(:kanzume)
      end

      it "returns a 302 response" do
        kanzume_params = FactoryBot.attributes_for(:kanzume) 
        patch :update, params: { id: @kanzume.id, kanzume: kanzume_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        kanzume_params = FactoryBot.attributes_for(:kanzume) 
        patch :update, params: { id: @kanzume.id, kanzume: kanzume_params }
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#destroy" do
    context "as a correct user" do
      before do
        login(user)
        @kanzume = FactoryBot.create(:kanzume, user: user)
      end

      it "deletes a kanzume" do
        expect {
          delete :destroy, params: { id: @kanzume.id }
        }.to change(user.kanzumes, :count).by(-1)
      end
    end

    context "as an incorrect user" do
      before do
       
        other_user = FactoryBot.create(:user)
        @kanzume = FactoryBot.create(:kanzume, user: other_user)
      end

      it 'does not delete the kanzume' do
        login(user)
        expect {
          delete :destroy, params: {id: @kanzume.id}
        }.to_not change(Kanzume, :count)
      end

      it "redirects to root" do
        login(user)
        delete :destroy, params: {id: @kanzume.id}
        expect(response).to redirect_to root_path
      end 
    end

    context "as a guest" do
      before do
        @kanzume = FactoryBot.create(:kanzume)
      end

      it "returns a 302 response" do
        delete :destroy, params: {id: @kanzume.id}
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        delete :destroy, params: {id: @kanzume.id}
        expect(response).to redirect_to "/login"
      end

      it "does not delete the project" do
        expect {
          delete :destroy, params: {id: @kanzume.id}
        }.to_not change(Kanzume, :count)
      end
    end
  end


end
