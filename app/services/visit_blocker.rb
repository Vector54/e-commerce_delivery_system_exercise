class VisitBlocker < ApplicationService
  attr_reader :user_boolean, :admin_boolean

  def initialize(user_boolean, admin_boolean)
    @user_boolean = user_boolean
    @admin_boolean = admin_boolean
  end

  def visit_block
    
  end
end