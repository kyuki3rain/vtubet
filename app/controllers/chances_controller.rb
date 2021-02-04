class ChancesController < ApplicationController
    def index
        @contest = Contest.find(params[:contest_id])

        if params[:bet_type]
            data = @contest.chances.where(bet_type: params[:bet_type]).map do |chance|
                       chance_data(chance)
                   end
        else
            data = Chance.bet_types.keys.index_with do |k|
              @contest.chances.where(bet_type: k).map do |chance|
                chance_data(chance)
              end
            end
        end

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