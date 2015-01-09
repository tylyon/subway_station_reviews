class VotesController < ApplicationController
  before_filter :setup

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    flash[:notice] = "Vote deleted"
    redirect_to :back
  end

  private

  def setup
    @review = Review.find(params[:review_id])
    @vote = @review.votes.where(user_id: current_user.id).first
  end

  def vote_params
    params.require(:vote).permit(:value, :review)
  end

  def update_vote(new_value)
    if @vote # if it exists, update it
      @vote.update_attribute(:value, new_value)
      flash[:notice] = "Vote changed"
    else # create it
      @vote = current_user.votes.create(value: new_value, review: @review)
      flash[:notice] = "Thanks for your vote"
      VoteMailer.notification(@vote).deliver_now
    end
  end
end
