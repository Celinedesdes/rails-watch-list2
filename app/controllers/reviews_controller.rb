class ReviewsController < ApplicationController
  before_action :set_list

  def create
    @review = @list.reviews.build(review_params)
    if @review.save
      redirect_to list_path(@list), notice: "Avis ajouté !"
    else
      @bookmark = @list.bookmarks.build
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @list.reviews.find(params[:id]).destroy
    redirect_to list_path(@list), notice: "Avis supprimé."
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
