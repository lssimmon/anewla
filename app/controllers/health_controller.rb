class HealthController < ApplicationController
  before_action :require_login

  def index
    @latest_weight = current_user.weight_entries.recent.first
  end
end
