class VoteMailer < ApplicationMailer
  default from: 'from@example.com'

  def notification(vote)
    @vote = vote
    mail to: vote.review.user.email,
      subject: 'Your review has a new vote!'
  end
end
