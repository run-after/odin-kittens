class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Yay, new kitten created!"
      redirect_to @kitten
    else
      puts @kitten.errors.full_messages
      render :new
    end
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
    
    @age_range = Array(1..15)
    @other_range = Array(1..10)
    
  end

  def update
    @kitten = Kitten.find(params[:id])
    @kitten.update(kitten_params)
    redirect_to @kitten
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    redirect_to kittens_path
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  private
    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
