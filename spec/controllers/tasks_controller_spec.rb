require 'rails_helper'

describe TasksController do

  describe 'guest user' do #Guest 
    it 'redirects guest to login page' do
      get :new
      expect(response).to redirect_to(new_user_session_url)
    end
  end #Guest //

  describe 'autenticated user' do #Logged in User
    let(:user) {FactoryBot.create(:user)}
    before do
      sign_in(user)
    end

    context 'User is THE OWNER of the task' do
      let(:task) {FactoryBot.create(:task, user: user)}

      describe 'GET #index' do
        # it "assigns the requested user as @tasks" do
        #   task = FactoryBot.create(:task)
        #   get :index
        #   expect(assigns(:tasks)).to match_array(task)
        # end

        it 'renders :index template' do
          get :index
          expect(response).to render_template(:index)
        end
      end

      describe 'GET #edit' do

        it 'renders :edit template' do
          get :edit, params: { id: task }
          expect(response).to render_template :edit
        end

        it 'assigns the requested task to template' do
          get :edit, params: { id: task }
          expect(assigns(:task)).to eq(task)
        end 
      end

      describe 'PUT #update' do

        context 'valid data' do
          let(:valid_data) { FactoryBot.attributes_for(:task, title: 'Updated task') }

          it 'redirects to task #index' do
            put :update, params: { id: task, task: valid_data}
            expect(response).to redirect_to(tasks_path)
          end
          it 'updates task in a data base' do
            put :update, params: { id: task, task: valid_data}
            task.reload
            expect(task.title).to eq('Updated task')
          end
        end

        context 'invalid data' do
          let(:invalid_data) { FactoryBot.attributes_for(:task, title: nil) }

          it 'renders back :edit template' do
            put :update, params: { id: task, task: invalid_data }
            expect(response).to render_template(:edit)
          end

          it 'doesn\'t update task in data base' do
             put :update, params: { id: task, task: invalid_data }
             task.reload
             expect(task.title).not_to eq(nil)
          end
        end
      end

      describe 'GET #new' do
        it 'renders :new template' do
          get :new
          expect(response).to render_template(:new)
        end

        it 'assigns new Task to @tasks' do
          get :new
          expect(assigns(:task)).to be_a_new(Task)
        end
      end

      describe 'GET #show' do

        it 'renders :show template' do
          get :show, params: { id: task }
          expect(response).to render_template(:show)
        end

        it 'assigns requested task to @task' do
          get :show, params: { id: task }
          expect(assigns(:task)).to eq(task)
        end
      end

      describe 'POST create' do
        context 'valid data' do
          let(:valid_data) { FactoryBot.attributes_for(:task) }
          it 'redirects to tasks path after task creating' do
            post :create, params: { task: valid_data }
            expect(response).to redirect_to(tasks_path)
          end

          it 'creates new task in data base' do
            expect {
              post :create, params: { task: valid_data }
            }.to change(Task, :count).by(1)
          end
        end


        context 'invalid data' do
          let(:invalid_data) { FactoryBot.attributes_for(:task, title: nil) }

          it 'renders back a :new template' do
            post :create, params: { task: invalid_data }
            expect(response).to render_template(:new)
          end
          it 'it doesn\'t create new task in data base' do
            expect {
               post :create, params: { task: invalid_data }
             }.not_to change(Task, :count)
          end
        end
      end

      describe 'DELETE destroy' do

        it 'redirects to root after delete' do
          delete :destroy, params: { id: task }
          expect(response).to redirect_to(root_path)
        end

        it 'havent in data base after delete' do
          delete :destroy, params: { id: task }
          expect(Task.exists?(task.id)).to be_falsy
        end
      end
    end

    context 'User is NOT THE OWNER of the task' do
    let(:other_user) {FactoryBot.create(:other_user)}
    before do
      sign_in(other_user)
    end

      describe 'GET #edit' do
        it 'redirects to tasks page' do
          get :edit, params: {id: FactoryBot.create(:task, user: user)}
          expect(response).to redirect_to(tasks_path)
        end
      end
    end
  end #Logged in User//
end