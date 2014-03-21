class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def index
    @problems = Problem.all

    @solvings = Solving.where(problem_id: @problems).
                        group_by(&:problem_id)
  end

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def create
    @problem = Problem.new(problem_params)
    if @problem.save
      redirect_to @problem, notice: 'Problem was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to @problem, notice: 'Problem was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @problem.destroy
    redirect_to problems_url
  end

  def multi
  end

  def create_multi
    params[:quantity].to_i.times do |number|
      @problem = Problem.new(name: "Zadanie #{(number+1)}", start_time: params[:start_time], end_time: params[:end_time])
      @problem.save
    end
    redirect_to problems_path, notice: "Yey! You have created new problems"
  end

  def start
    @solving = Solving.new(user_id: current_user_id, status: :solving, problem_id: params[:id])
    if @solving.save
      redirect_to problems_path
    else
      redirect_to problems_path, alert: "Log in to start solving"
    end
  end

  def re_solve
    @solving = Solving.where(user_id: current_user_id, problem_id: params[:id]).first
    update_solving_status :solving
  end

  def finish
    @solving = Solving.where(user_id: current_user_id, problem_id: params[:id]).first
    update_solving_status :finished
  end

  def abandon
    @solving = Solving.where(user_id: current_user_id, problem_id: params[:id]).first
    update_solving_status :abandoned
  end

  private

  def update_solving_status status
    if @solving
      @solving.update(status: status)
      redirect_to problems_path
    else
      redirect_to problems_path, alert: "You havent started solving yet"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_problem
    @problem = Problem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def problem_params
    params.permit(:name, :start_time, :end_time)
  end
end
