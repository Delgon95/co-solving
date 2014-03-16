class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # creating multiple problems
  def multi
  end

  def create_multi
    if params[:quantity].empty? || params[:start_time].empty? || params[:end_time].empty?
      flash[:error] = "You have to specify all parameters"
      redirect_to multi_problems_path
    else
      params[:quantity].to_i.times do |number|
        @problem = Problem.new(name: "Zadanie #{(number+1)}", start_time: params[:start_time], end_time: params[:end_time])
        @problem.save
      end
      flash[:notice] = "Yey! You have created new problems"
      redirect_to problems_path
    end
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)
    if params[:name].empty? || params[:start_time].empty? || params[:end_time].empty?
      flash[:error] = "You have to specify all parameters"
      redirect_to new_problem_path
    else
      respond_to do |format|
        if @problem.save
          format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
          format.json { render action: 'show', status: :created, location: @problem }
        else
          format.html { render action: 'new' }
          format.json { render json: @problem.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    if params[:name].empty? || params[:start_time].empty? || params[:end_time].empty?
      flash[:error] = "You have to specify all parameters"
      redirect_to new_problem_path
    else
      respond_to do |format|
        if @problem.update(problem_params)
          format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @problem.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.permit(:name, :start_time, :end_time)
    end
end
