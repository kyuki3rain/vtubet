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
      members: @contest.members.pluck(:name),
      chances: Chance.bet_types.keys.index_with do |k|
        @contest.chances.where(bet_type: k)
                .includes({participations: :member}).map do |chance|
          {
            id: chance.id,
            rate: chance.rate,
            member_names: chance.participations.map do |participation|
              participation.member.name
            end,
            is_bet: current_user && !chance.bets.find_by(user_id: current_user.id).nil?
          }
        end
      end
    }

    render json: data
  end
end
