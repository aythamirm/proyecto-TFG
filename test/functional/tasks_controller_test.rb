require 'test_helper'
class TasksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = User.create(first_name: 'Jhon', last_name: 'wu', email: 'prueba@gmail.com', password: '123456789', password_confirmation: '123456789')
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { task_name: 'task1', note: 'task 1 is  the first task', action: 'Inbox' } 
    end

    assert_redirected_to tasks_path
  end

  test "should show task" do
    @task = Task.create(task_name: 'task1', note: 'task 1 is  the first task', action: 'Inbox' )
    get :show, id: @task.id
    assert_response :success
  end

  test "should get edit" do
    @task = Task.create(task_name: 'task1', note: 'task 1 is  the first task', action: 'Inbox' )
    get :edit, id: @task.id
    assert_response :success
  end

  test "should update task" do
    @task = Task.create(task_name: 'task1', note: 'task 1 is  the first task', action: 'Inbox' )
    put :update, id: @task.id, task: { task_name: @task.task_name, note: @task.note, action: @task.action }
    assert_redirected_to task_path
  end

  test "should destroy task" do
    @task = Task.create(task_name: 'task1', note: 'task 1 is  the first task', action: 'Inbox' )
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task.id
    end

    assert_redirected_to tasks_path
  end
end
