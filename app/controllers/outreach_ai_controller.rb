class OutreachAiController < ApplicationController

  def index
  end

  def new
    @outreach_type = params[:outreach_type]
  end

  def create
    puts "AI PARAMS", params[:outreach_ai]

    redirect_to outreach_ai_index_path
  end
end
