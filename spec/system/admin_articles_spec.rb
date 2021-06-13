require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) { create :user, :admin }
  let(:draft_article) { create :article, :draft }
  let(:future_article) { create :article, :future }
  let(:past_article) { create :article, :past }
  before do
    login(admin)
  end

  describe '記事編集画面' do
    context '公開日時を未来の日付に設定して「公開する」をおす' do
      it 'ステータスを「公開待ち」に変更して「記事を公開待ちにしました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開待ちにしました'), '「公開待ちにしました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開待ち'), 'ステータスが「公開待ち」になっていません'
      end
    end

    context '公開日時を過去の日付に設定して「公開する」をおす' do
      it 'ステータスを「公開」に変更して「記事を公開しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(past_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開しました'), '「公開しました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開'), 'ステータスが「公開」になっていません'
      end
    end

    context 'ステータスが「下書き」の状態で、公開日時を未来の日付に設定して「更新する」をおす' do
      it 'ステータスを「公開待ち」に変更して「更新しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開待ち'), 'ステータスが「公開待ち」になっていません'
      end
    end

    context 'ステータスが「下書き」の状態で、公開日時を過去の日付に設定して「更新する」をおす' do
      it 'ステータスを「公開」に変更して「更新しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(past_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開'), 'ステータスが「公開」になっていません'
      end
    end

    context 'ステータスが「下書き」の状態で、「更新する」をおす' do
      it 'ステータスは「下書き」のまま「更新しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(draft_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_selector('.form-control', text: '下書き'), 'ステータスが「下書き」になっていません'
      end
    end

    describe '検索機能' do
      let(:article_with_author) {create(:article, :with_author, author_name: '小林')}
      let(:article_with_another_author) {create(:article, :with_author, author_name: '鈴木')}
      let(:article_with_tag) {create(:article, :with_tag, tag_name: 'Ruby')}
      let(:article_with_another_tag) {create(:article, :with_tag, tag_name: 'PHP')}

      let(:draft_article_with_sentence) {create(:article, :draft, :with_sentence, sentence_body: '基礎編アプリの記事')}
      let(:past_article_with_sentence) {create(:article, :past, :with_sentence, sentence_body: '基礎編アプリの記事')}
      let(:future_article_with_sentence) {create(:article, :future, :with_sentence, sentence_body: '基礎編アプリの記事')}
      let(:draft_article_with_another_sentence) {create(:article, :draft, :with_sentence, sentence_body: '応用編アプリの記事')}
      let(:past_article_with_another_sentence) {create(:article, :past, :with_sentence, sentence_body: '応用編アプリの記事')}
      let(:future_article_with_another_sentence) {create(:article, :future, :with_sentence, sentence_body: '応用編アプリの記事')}

      it '著者名で絞り込み検索ができること' do
        article_with_author
        article_with_another_author
        visit admin_articles_path
        within 'select[name="q[author_id]"]' do
          select '小林'
        end
        #expect(page).to have_selector('.form-control', text: '小林')
        click_on '検索'
        expect(page).to have_content(article_with_author.title), '著者名での検索ができていません'
        expect(page).not_to have_content(article_with_another_author.title), '著者名での絞り込みができていません'
      end

      it 'タグで絞り込み検索ができること' do
        article_with_tag
        article_with_another_tag
        visit admin_articles_path
        within 'select[name="q[tag_id]"]' do
          select 'Ruby'
        end
        # expect(page).to have_selector('.form-control', text: 'Ruby')
        click_on '検索'
        expect(page).to have_content(article_with_tag.title), 'タグでの検索ができていません'
        expect(page).not_to have_content(article_with_another_tag.title), 'タグ名での絞り込みができていません'
      end

      it '公開状態の記事について、本文で絞り込み検索ができること' do
        visit edit_admin_article_path(past_article_with_sentence.uuid)
        click_on '公開する'
        visit edit_admin_article_path(past_article_with_another_sentence.uuid)
        click_on '公開する'
        visit admin_articles_path
        fill_in 'q[body]', with: '基礎編アプリ'
        click_on '検索'
        expect(page).to have_content(past_article_with_sentence.title), '記事内容での検索ができていません'
        expect(page).not_to have_content(past_article_with_another_sentence.title), '記事内容での絞り込みができていません'
      end

      it '公開待ち状態の記事について、本文で絞り込み検索ができること' do
        visit edit_admin_article_path(future_article_with_sentence.uuid)
        click_on '公開する'
        visit edit_admin_article_path(future_article_with_another_sentence.uuid)
        click_on '公開する'
        visit admin_articles_path
        fill_in 'q[body]', with: '基礎編アプリ'
        click_on '検索'
        expect(page).to have_content(future_article_with_sentence.title), '記事内容での検索ができていません'
        expect(page).not_to have_content(future_article_with_another_sentence.title), '記事内容での絞り込みができていません'
      end

      it '下書き状態の記事について、本文で絞り込み検索ができること' do
        draft_article_with_sentence
        draft_article_with_another_sentence
        visit admin_articles_path
        fill_in 'q[body]', with: '基礎編アプリ'
        click_on '検索'
        expect(page).to have_content(draft_article_with_sentence.title), '記事内容での検索ができていません'
        expect(page).not_to have_content(draft_article_with_another_sentence.title), '記事内容での絞り込みができていません'
      end

    end

  end
end