class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
  end

  def about
  end

  def hook
  	p params
  end
end
