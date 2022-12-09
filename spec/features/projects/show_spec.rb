require 'rails_helper'

# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)

RSpec.describe 'the songs show page' do
  describe 'as a visitor' do
    describe 'I visit a projects show page' do
      it 'I see that projects name and material' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

        visit "/projects/#{news_chic.id}"

        expect(page).to have_content(news_chic.name)
        expect(page).to have_content(news_chic.material)
      end
    end
  end
end