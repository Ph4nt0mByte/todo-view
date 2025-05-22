class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    session[:last_visited] = Time.current
    session[:visit_count] ||= 0
    session[:visit_count] += 1
    @visit_count = session[:visit_count]

    @todos = Todo.all
  end

  # GET /todos/1 or /todos/1.json
  def show
    session[:show_visit_count] ||= 0
    session[:show_visit_count] += 1
    @visit_count = session[:show_visit_count]
  end

  # GET /todos/new
  def new
    @todo = Todo.new
    session[:new_visit_count] ||= 0
    session[:new_visit_count] += 1
    @visit_count = session[:new_visit_count]
  end

  # GET /todos/1/edit
  def edit
    session[:edit_visit_count] ||= 0
    session[:edit_visit_count] += 1
    @visit_count = session[:edit_visit_count]
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, status: :see_other, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :description, :status)
    end
end
