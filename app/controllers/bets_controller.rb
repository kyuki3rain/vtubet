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
          member: {
            name: bet.chance.participation.member.name
          },
          contest: {
            id: bet.chance.participation.contest.id,
            title: bet.chance.participation.contest.title
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
