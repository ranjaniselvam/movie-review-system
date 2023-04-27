class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review,  only: %i[ show edit update destroy upvote downvote]
  load_and_authorize_resource

  # GET /reviews or /reviews.json
  def index
    @reviews = @movie.reviews.all

    @reviews = @reviews.paginate(page: params[:page])
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = @movie.reviews.build
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_path(@movie), notice: "Review Added !!" }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to movie_path(@movie), notice: "Review updated !!" }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to movie_path(@movie), notice: "Review destroyed !!" }
      format.json { head :no_content }
    end
  end

  def upvote
    unless signed_in?
      redirect_to new_user_session_path
    else
      @review.liked_by current_user
      redirect_to movie_path(@movie)
    end
  end

  def downvote
    unless signed_in?
      redirect_to new_user_session_path
    else
      @review.downvote_from current_user
      redirect_to movie_path(@movie)
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = @movie.reviews.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:comment,:ratings)
      # params.fetch( :review, {})
    end
end
