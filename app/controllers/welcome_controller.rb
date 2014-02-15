class WelcomeController < ApplicationController
  skip_before_filter :authorize, :except => [:settings]
  def index
  end

  def settings
  end

  def about
  end
end
