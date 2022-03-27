class TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  # GET /todos
  def index
    @todos = Todo.all

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    render json: { message: 'Todo was successfully deleted!' }
  rescue StandardError
    render json: { message: 'We were unable to delete this todo!' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e }
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
