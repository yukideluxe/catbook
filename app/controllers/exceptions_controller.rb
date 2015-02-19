class ExceptionsController < ApplicationController

  def show
    @status_code = env["PATH_INFO"][1..-1]

    respond_to do |format|
      format.html {  }
      format.json { head @status_code }
    end
  end

end
