require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) { create :user, :admin }
  describe '記事作成画面で画像ブロックを追加' do
    context '画像を添付せずにプレビューを閲覧' do
      it '正常に表示される' do
        login(admin)
        click_link'記事'
        click_link'新規作成'
        fill_in 'タイトル', with: 'test'
        fill_in 'スラッグ', with: 'test_slag'
        click_on '登録する'
        click_on 'ブロックを追加する'
        click_on '画像'
        click_on 'プレビュー'
        switch_to_window(windows.last)
        expect(page).to have_content 'test'
      end
    end

    context '画像を添付せずにプレビューを閲覧' do
      fit '正常に表示される' do
        login(admin)
        click_link'記事'
        click_link'新規作成'
        fill_in 'タイトル', with: 'test'
        fill_in 'スラッグ', with: 'test_slag'
        click_on '登録する'
        click_on 'ブロックを追加する'
        click_on '文章'
        click_on 'プレビュー'
        switch_to_window(windows.last)
        expect(page).to have_content 'test'
      end
    end
  end
end