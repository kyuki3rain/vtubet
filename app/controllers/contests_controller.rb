class ContestsController < ApplicationController
  def index
    @contests = Contest.published.includes(:members)

    data = @contests.map do |contest|
      {
        id: contest.id,
        title: contest.title,
        members: contest.members.map do |member|
          {name: member.name}
        end
      }
    end

    render json: data
  end
  
  def show
    @contest = Contest.find(params[:id])

    data = {
      title: @contest.title,
      member_names: @contest.members.pluck(:name)
    }

    render json: data
  end

  private

  def chance_data(chance)
    {
      id: chance.id,
      rate: chance.rate,
      member_names: chance.chance_participations.order(:position).map do |chance_participation|
        chance_participation.participation.member.name
      end,
      is_bet: current_user && !chance.bets.find_by(user_id: current_user.id).nil?,
      has_order: chance.exacta? || chance.tierce?
    }
  end
end
