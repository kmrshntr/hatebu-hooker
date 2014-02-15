class WelcomeController < ApplicationController
  protect_from_forgery with: :exception, except: ["hook"]
  skip_before_filter :authorize
  def index
  end

  def about
  end

  def hook
    p params
	respond_to do |format|
        format.json { head :no_content }
    end
  end
end
