class ChargesController < ApplicationController
  def new
  end

  def create
    charge = Charge.new(current_user, params[:stripeToken])
    charge.process
    redirect_to dashboard_path
  end
end
