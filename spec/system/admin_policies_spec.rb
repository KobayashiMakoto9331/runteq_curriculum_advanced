require 'rails_helper'

RSpec.describe 'AdminPolicies', type: :system do
  let(:admin) { create :user, :admin }
  let(:writer) { create :user, :writer }
  let(:editor) { create :user, :editor }

  let(:category) { create :category}
  let!(:tag) {create :tag}
  let!(:author) {create :author}

  before do
    driven_by(:rack_test)
  end
  

  describe 'ライターのアクセス権限' do
    before do
      login(writer)
    end

    context 'ダッシュボードへのアクセス権限' do
      it 'カテゴリーページへのリンクが表示されていないこと' do
        expect(page).not_to have_link('カテゴリー')
      end

      it 'タグページへのリンクが表示されていないこと' do
        expect(page).not_to have_link('タグ')
      end

      it '著者ページへのリンクが表示されていないこと' do
        expect(page).not_to have_link('著者')
      end
    end

    context 'カテゴリー一覧にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit admin_categories_path
        expect(page).to have_http_status(403)
        expect(page).not_to have_content(category.name)
      end
    end

    context 'カテゴリー編集にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(403)
        expect(page).not_to have_selector("input[value = #{category.name}]")
      end
    end

    context 'タグ一覧にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit admin_tags_path
        expect(page).to have_http_status(403)
        expect(page).not_to have_content(tag.name)
      end
    end

    context 'タグ編集にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(403)
        expect(page).not_to have_content("input[value=#{tag.name}]")
      end
    end

    context '著者一覧にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit admin_authors_path
        expect(page).to have_http_status(403)
        expect(page).not_to have_content(author.name)
      end
    end

    context '著者編集にアクセスした' do
      it 'アクセス失敗になり、403エラーが表示される' do
        visit edit_admin_author_path(author)
        expect(page).to have_http_status(403)
        expect(page).not_to have_content("input[value=#{author.name}]")
      end
    end

  end

  describe '編集者のアクセス権限' do
    before do
      login(editor)
    end

    context 'ダッシュボードへのアクセス権' do
      it 'カテゴリーページのリンクが表示されること' do
        expect(page).to have_link('カテゴリー')
      end

      it 'タグページへのリンクが表示されること' do
        expect(page).to have_link('タグ')
      end

      it '著者ページへのリンクが表示されること' do
        expect(page).to have_link('著者')
      end
    end

    context 'カテゴリー一覧にアクセス' do
      it 'アクセス成功になり、カテゴリー一覧ページが表示されること' do
        visit admin_categories_path
        expect(page).to have_http_status(200)
        expect(page).not_to have_content(category.name)
      end
    end

    context 'カテゴリー編集にアクセス' do
      it 'アクセス成功になり、カテゴリー編集ページが表示されること' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{category.name}]")
      end
    end

    context 'タグ一覧にアクセス' do
      it 'アクセス成功になり、タグ一覧ページが表示されること' do
        visit admin_tags_path
        expect(page).to have_http_status(200)
        expect(page).to have_content(tag.name)
      end
    end

    context 'タグ編集にアクセス' do
      it 'アクセス成功になり、タグ編集ページが表示されること' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{tag.name}]")
      end
    end

    context '著者一覧にアクセス' do
      it 'アクセス成功になり、著者一覧ページが表示されること' do
        visit admin_authors_path
        expect(page).to have_http_status(200)
        expect(page).to have_content(author.name)
      end
    end

    context '著者編集にアクセス' do
      it 'アクセス成功になり、タグ一覧ページが表示されること' do
        visit edit_admin_author_path(author)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{author.name}]")
      end
    end

  end

  describe '管理者のアクセス権限' do
    before do
      login(admin)
    end

    context 'ダッシュボードへのアクセス権' do
      it 'カテゴリーページのリンクが表示されること' do
        expect(page).to have_link('カテゴリー')
      end

      it 'タグページへのリンクが表示されること' do
        expect(page).to have_link('タグ')
      end

      it '著者ページへのリンクが表示されること' do
        expect(page).to have_link('著者')
      end
    end

    context 'カテゴリー一覧にアクセス' do
      it 'アクセス成功になり、カテゴリー一覧ページが表示されること' do
        visit admin_categories_path
        expect(page).to have_http_status(200)
        expect(page).not_to have_content(category.name)
      end
    end

    context 'カテゴリー編集にアクセス' do
      it 'アクセス成功になり、カテゴリー編集ページが表示されること' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{category.name}]")
      end
    end

    context 'タグ一覧にアクセス' do
      it 'アクセス成功になり、タグ一覧ページが表示されること' do
        visit admin_tags_path
        expect(page).to have_http_status(200)
        expect(page).to have_content(tag.name)
      end
    end

    context 'タグ編集にアクセス' do
      it 'アクセス成功になり、タグ編集ページが表示されること' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{tag.name}]")
      end
    end

    context '著者一覧にアクセス' do
      it 'アクセス成功になり、著者一覧ページが表示されること' do
        visit admin_authors_path
        expect(page).to have_http_status(200)
        expect(page).to have_content(author.name)
      end
    end

    context '著者編集にアクセス' do
      it 'アクセス成功になり、タグ一覧ページが表示されること' do
        visit edit_admin_author_path(author)
        expect(page).to have_http_status(200)
        expect(page).to have_selector("input[value=#{author.name}]")
      end
    end

  end
end
