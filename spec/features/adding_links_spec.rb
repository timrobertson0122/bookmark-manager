require 'spec_helper'

feature 'User adds a new link' do
  scenario 'when browsing the new links page' do
    expect(Link.count).to eq(0)
    visit '/links/new'
    add_link('http://www.makersacademy.com/', 'Makers Academy')
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq('http://www.makersacademy.com/')
    expect(link.title).to eq('Makers Academy')
  end

  scenario 'with a few tags' do
    visit '/links/new'
    add_link('http://www.makersacademy.com/', 'Makers Academy', %w(education ruby))
    link = Link.first
    expect(link.tags.map(&:text)).to include 'education', 'ruby'
  end
end


  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', with: url
      fill_in 'title', with: title
      fill_in 'tags', with: tags.join(' ')
      click_button 'Add link'
    end
  end
