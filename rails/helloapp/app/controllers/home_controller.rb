class HomeController < ApplicationController
  def index
    render plain: 'Hello, worlddddd!'
  end

  def hello
    @student = ::Student.find params[:id]
  end
end
