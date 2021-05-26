require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) { create :user, :admin }

  before do
    login(admin)
  end

  describe'タグ一覧画面' do
    it '正常に表示される' do
      visit admin_tags_path
      within('.breadcrumb') do
        expect(page).to have_content('Home'), 'Homeというパンくずが表示されていません'
        expect(page).to have_content('タグ'), 'タグというパンくずが表示されていません'
      end
    end

    it 'Homeというパンくずをクリックした時、ホームに遷移する' do
      visit admin_tags_path
      within('.breadcrumb') do
        click_on 'Home'
      end
      expect(current_path).to eq(admin_dashboard_path), 'Homeというパンくずをクリックした時、ホームに遷移していません'
    end

  end

  describe'タグ編集画面' do
    let!(:tag) { create :tag }
    it 'Home > タグ > タグ編集 というパンくずが表示されていること' do
      visit edit_admin_tag_path(tag)
      within('.breadcrumb') do
        expect(page).to have_content('Home'), 'Homeというパンくずが表示されていません'
        expect(page).to have_content('タグ'), 'Homeというパンくずが表示されていません'
        expect(page).to have_content('タグ編集'), 'タグ編集というパンくずが表示されていません'
      end
    end

    fit'「タグ」のパンくずをクリックした時、タグの一覧画面に遷移すること' do
      visit edit_admin_tag_path(tag)
      within('.breadcrumb') do
        click_on 'タグ'
      end
      expect(current_path).to eq admin_tags_path
    end
  end

end