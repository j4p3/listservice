class StaticController < ApplicationController
  def about
    render 'static/about'
  end
  def four_oh_four
    render file: "#{Rails.root}/public/404.html", status: 404, layout: 'application'
  end
end
