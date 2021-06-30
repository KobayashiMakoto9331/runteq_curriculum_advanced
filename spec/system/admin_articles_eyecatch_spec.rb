require 'rails_helper'

RSpec.describe 'AdminArticlesEyecatch', type: :system do
  let(:admin) { create :user, :admin }
  let!(:article) { create :article }

  before do
    login(admin)
    visit admin_articles_path
    click_link '編集', href: edit_admin_article_path(article.uuid)
    click_button '更新する'
    attach_file 'article[eye_catch]', "#{Rails.root}/spec/fixtures/images/runteq_man.jpg"
  end

  describe 'アイキャッチの横幅を変更' do
    context '横幅を100~700で変更した場合' do
      fit '記事の更新に成功し、プレビューでアイキャッチが表示される' do
        eyecatch_width = rand(100..700)
        fill_in 'article[eyecatch_width]', with: eyecatch_width
        click_on '更新する'
        expect(page).to have_content "更新しました"
      end
    end

    context '横幅を99に変更した場合' do
      it '記事の更新に失敗する' do
      end
    end

    context '横幅を701に変更した場合' do
      it '記事の更新に失敗する' do
      end
    end
  end

  describe 'アイキャッチの位置を変更' do
    context 'アイキャッチの位置を「中央寄せ」に変更した場合' do
      it '記事の更新に成功し、プレビューでアイキャッチが「中央寄せ」表示される' do
      end
    end

    context 'アイキャッチの位置を「左寄せ」に変更した場合' do
      it '記事の更新に成功し、プレビューでアイキャッチが「中央寄せ」表示される' do
      end
    end

    context 'アイキャッチの位置を「右寄せ」に変更した場合' do
      it '記事の更新に成功し、プレビューでアイキャッチが「中央寄せ」表示される' do
      end
    end
  end
end