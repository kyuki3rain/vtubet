class BetsController < ApplicationController
  def index
    @bets = current_user.bets

    data = @bets.map do |bet|
      {
        id: bet.id,
        point: bet.point,
        status: bet.status,
        chance: {
          rate: bet.chance.rate,
          bet_type: bet.chance.bet_type,
          member_names: bet.chance.chance_participations.order(:position).map do |chance_participation|
            chance_participation.participation.member.name
          end,
          contest: {
            id: bet.chance.participations.first.contest.id,
            title: bet.chance.participations.first.contest.title
          }
        }
      }
    end

    render json: data
  end

  def create
    @chance = Chance.find(params[:chance_id])
    @bet = @chance.bets.build(bet_params)
    @bet.user = current_user

    @bet.save!

    @bet.publish!
  end

  def update
    @bet = current_user.bets.find(params[:id])
    @bet = @chance.build_bets(bet_params)
  end

  def publish
    @bet = current_user.bets.find(params[:id])
    @bet.publish!
  end

  def destroy
    @bet = current_user.bets.find(params[:id])
    @bet.destroy!
  end

  private

  def bet_params
    params.require(:bet).permit(
      :point
    )
  end
end
