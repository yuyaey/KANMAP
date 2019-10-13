require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

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
        @item = FactoryBot.create(:item, user: user)
      end

      it "responds successfully" do
        get :show, params: {id: @item.id}
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#create" do
    context "as a loggined user" do
      before do
        other_user = FactoryBot.create(:user)
        kaznume = FactoryBot.create(:kanzume, id: 99)
        item_icon = FactoryBot.create(:item_icon, id: 99)
      end

        context "with valid attributes" do
          it "add a item" do
            login(user)
            @item_params = FactoryBot.attributes_for(:item, :forpost, user: user)
            expect {
              post :create, params: { item: @item_params, user: user}
            }.to change{user.items.count}.by(1)
          end
        end

        context "with invalid attributes" do
          it "does not add a item" do
            item_params = FactoryBot.attributes_for(:item, :invalid)
            login(user)
              expect {
                post :create, params: { item: item_params }
              }.to_not change(user.items, :count)
          end
        end
    end

    context "as a guest" do
      it "returns a 302 response" do
        item_params = FactoryBot.attributes_for(:item) 
        post :create, params: {item: item_params}
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        item_params = FactoryBot.attributes_for(:item) 
        post :create, params: {item: item_params}
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#update" do
    context "as a loggined user" do
      before do
        login(user)
        @item = FactoryBot.create(:item, user: user)
      end
      context "with valid attributes" do
        it "updates a item" do
          item_params = FactoryBot.attributes_for(:item, name: "New item Name")
          patch :update, params: { id: @item.id, item: item_params }
          expect(@item.reload.name).to eq "New item Name"
        end
      end

      context "with invalid attributes" do
        it "does not update a item" do
          item_params = FactoryBot.attributes_for(:item, :invalid)
          patch :update, params: { id: @item.id, item: item_params }
          expect(@item.reload.name).not_to eq true
        end
      end
    end

    context "as a guest" do
      before do
        @item = FactoryBot.create(:item)
      end

      it "returns a 302 response" do
        item_params = FactoryBot.attributes_for(:item) 
        patch :update, params: { id: @item.id, item: item_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        item_params = FactoryBot.attributes_for(:item) 
        patch :update, params: { id: @item.id, item: item_params }
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#destroy" do
    context "as a correct user" do
      before do
        login(user)
        @item = FactoryBot.create(:item, user: user)
      end

      it "deletes a item" do
        expect {
          delete :destroy, params: { id: @item.id }
        }.to change(user.items, :count).by(-1)
      end
    end

    context "as an incorrect user" do
      before do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @item = FactoryBot.create(:item, user: other_user)
      end

      it 'does not delete the item' do
        login(user)
        expect {
          delete :destroy, params: {id: @item.id}
        }.to_not change(Item, :count)
      end

      it "redirects to root" do
        login(user)
        delete :destroy, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end 
    end

    context "as a guest" do
      before do
        @item = FactoryBot.create(:item)
      end

      it "returns a 302 response" do
        delete :destroy, params: {id: @item.id}
        expect(response).to have_http_status "302"
      end

      it "redirects to the log-in page" do
        delete :destroy, params: {id: @item.id}
        expect(response).to redirect_to "/login"
      end

      it "does not delete the project" do
        expect {
          delete :destroy, params: {id: @item.id}
        }.to_not change(Item, :count)
      end
    end
  end


end
