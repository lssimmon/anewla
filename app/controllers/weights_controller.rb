class WeightsController < ApplicationController
  before_action :require_login

  def index
    @unit = %w[lb kg oz].include?(params[:unit].to_s) ? params[:unit] : "lb"
    @weight_entries = current_user.weight_entries.chronological
    @chart_data = @weight_entries.map do |entry|
      {
        label: entry.recorded_on.strftime("%b %d"),
        weight: WeightEntry.convert_from_pounds(entry.weight, @unit)
      }
    end
  end

  def new
    @weight_entry = current_user.weight_entries.new(recorded_on: Date.current)
    @latest_weight = current_user.weight_entries.recent.first
  end

  def create
    unit = params.dig(:weight_entry, :unit).to_s
    @weight_entry = current_user.weight_entries.new(weight_entry_params)
    @weight_entry.weight = WeightEntry.convert_to_pounds(@weight_entry.weight, unit)

    if @weight_entry.save
      redirect_to weights_path(unit: unit), notice: "Weight entry added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def weight_entry_params
    params.require(:weight_entry).permit(:recorded_on, :weight)
  end
end
