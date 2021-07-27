require 'rails_helper'

RSpec.describe 'AdminArticlesEmbeddedMedia', type: :system do
  let(:admin) { create :user, :admin }
  let(:article) { create :article }

  describe '記事の埋め込みブロックを追加' do
    before do
      login(admin)
      article
      visit edit_admin_article_path(article.uuid)
      click_on 'ブロックを追加する'
      click_on '埋め込み'
      click_on '編集'
    end

    context 'Youtubeを選択しアップロード' do
      it 'プレビューした記事にYoutubeが埋め込まれていること' do
        select 'YouTube', from: 'embed[embed_type]'
        fill_in 'ID', with: 'https://youtu.be/dZ2dcC4OnQE'
        click_on '更新する', match: :first
        click_on 'プレビュー'
        switch_to_window(windows.last)
        expect(current_path).to eq(admin_article_preview_path(article.uuid))
        expect(page).to have_selector("iframe[src='https://www.youtube.com/embed/dZ2dcC4OnQE']")
      end
    end

    context 'Twitterを選択しアップロード' do
      it 'プレビューした記事にTwitterが埋め込まれていること' do
        select 'Twitter', from: 'embed[embed_type]'
        fill_in 'ID', with: 'https://twitter.com/_RUNTEQ_/status/1219795644807667712'
        click_on '更新する', match: :first
        click_on 'プレビュー'
        switch_to_window(windows.last)
        expect(current_path).to eq(admin_article_preview_path(article.uuid))
        sleep 2 # 全体テスト実行時に画面遷移が追いつかないので待機
        expect(page).to have_selector(".twitter-tweet")
      end
    end

  end
end