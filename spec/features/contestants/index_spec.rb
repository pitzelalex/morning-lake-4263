require 'rails_helper'

# As a visitor,
# When I visit the contestants index page ("/contestants")
# I see a list of names of all the contestants
# And under each contestants name I see a list of the projects (names) that they've been on

# (e.g.   Kentaro Kameyama
#         Projects: Litfit, Rug Tuxedo

#         Jay McCarroll
#         Projects: LeatherFeather)

RSpec.describe 'the contestants index page' do
  it 'I see a list of names of all the contestants' do
    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    visit '/contestants'

    expect(page).to have_content(jay.name)
    expect(page).to have_content(gretchen.name)
    expect(page).to have_content(kentaro.name)
    expect(page).to have_content(erin.name)
  end

  it "under each name I see a list of project names they're working on" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
  
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
  
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
  
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)

    visit '/contestants'
    
    expect(page).to have_content('Projects: Boardfit, Upholstery Tuxedo')
    expect(page).to have_content('Projects: News Chic, Upholstery Tuxedo')
  end
end
