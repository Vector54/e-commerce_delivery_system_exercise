# frozen_string_literal: true

class UpdateLineController < ApplicationController
  before_action :visit_blocker

  def create
    raw_line_params = params.permit(:latitude, :longitude, :order)
    str_line_params = raw_line_params[:latitude].to_s.insert(-6,
                                                             '.') + ', ' + raw_line_params[:longitude].to_s.insert(-6,
                                                                                                                   '.')

    ul = UpdateLine.new(coordinates: str_line_params)
    ul.order = Order.find(raw_line_params[:order].to_i)
    ul.save!

    redirect_to order_path(ul.order.id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
