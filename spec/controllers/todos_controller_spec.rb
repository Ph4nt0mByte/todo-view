require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:valid_attributes) {
    {
      title: 'Valid Todo',
      description: 'A valid todo description',
      status: 'pending'
    }
  }

  let(:invalid_attributes) {
    {
      title: '',
      status: 'invalid'
    }
  }

  describe 'GET #index' do
    it 'returns a success response' do
      todo = create(:todo)
      get :index
      expect(response).to be_successful
    end

    it 'assigns all todos as @todos' do
      todo = create(:todo)
      get :index
      expect(assigns(:todos)).to eq([todo])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      todo = create(:todo)
      get :show, params: { id: todo.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      todo = create(:todo)
      get :edit, params: { id: todo.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Todo' do
        expect {
          post :create, params: { todo: valid_attributes }
        }.to change(Todo, :count).by(1)
      end

      it 'redirects to the created todo' do
        post :create, params: { todo: valid_attributes }
        expect(response).to redirect_to(Todo.last)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: { todo: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new todo' do
        expect {
          post :create, params: { todo: invalid_attributes }
        }.to_not change(Todo, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          title: 'Updated Title',
          status: 'completed'
        }
      }

      it 'updates the requested todo' do
        todo = create(:todo)
        put :update, params: { id: todo.to_param, todo: new_attributes }
        todo.reload
        expect(todo.title).to eq('Updated Title')
        expect(todo.status).to eq('completed')
      end

      it 'redirects to the todo' do
        todo = create(:todo)
        put :update, params: { id: todo.to_param, todo: valid_attributes }
        expect(response).to redirect_to(todo)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        todo = create(:todo)
        put :update, params: { id: todo.to_param, todo: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested todo' do
      todo = create(:todo)
      expect {
        delete :destroy, params: { id: todo.to_param }
      }.to change(Todo, :count).by(-1)
    end

    it 'redirects to the todos list' do
      todo = create(:todo)
      delete :destroy, params: { id: todo.to_param }
      expect(response).to redirect_to(todos_path)
    end
  end
end
