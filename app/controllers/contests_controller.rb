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

    @contest.chances.each do |chance|
      chance.calc!
    end

    data = {
      title: @contest.title,
      members: @contest.participations.map do |participation|
        {
          name: participation.member.name,
          chances: participation.chances.map do |chance|
            {
              id: chance.id,
              bet_type: chance.bet_type,
              rate: chance.rate,
              is_bet: !chance.bets.find_by(user: current_user).nil?
            }
          end
        }
      end
    }

    render json: data
  end
end
