class HeroesController < ApplicationController
  def count
    @count = Hero.registerd_heroes_count
  end
end
