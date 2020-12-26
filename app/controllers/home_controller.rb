# frozen_string_literal: true

class HomeController < ApplicationController
  def index
#    sleep 10
  end

  def test_submit
#    sleep 3
#    redirect_to "/"
#    return

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("haha", "<p>WEEE #{params[:name]}</p>")
      end
      format.html { redirect_to "/" }
    end
  end
end
