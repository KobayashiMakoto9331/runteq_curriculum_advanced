require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) { create :user, :admin }
  before do
    login(admin)
  end

  describe '記事作成画面で画像ブロックを追加' do
    context '画像を添付せずにプレビューを閲覧' do
      it '正常に表示される' do
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

    describe '記事作成画面で文章を選択' do
      let!(:article) { create :article }
      context 'テキストを入力せずにプレビューを閲覧' do
        fit '記事レビュー画面に遷移できることを確認' do
          visit edit_admin_article_path(article.uuid)
          click_on 'ブロックを追加する'
          click_on '文章'
          click_on 'プレビュー'
          switch_to_window(windows.last)
          expect(page).to have_content(article.title)
        end
      end
    end
  end
end