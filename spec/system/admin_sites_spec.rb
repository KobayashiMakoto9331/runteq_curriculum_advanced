require 'rails_helper'

RSpec.describe 'AdminSites', type: :system do
  let(:admin) { create(:user, :admin) }
  let(:article) { create :article }

  before do
    login(admin)
    visit edit_admin_site_path
  end

  describe 'ブログのトップ画像を変更' do
    context 'トップ画像を１枚選択してアップロード' do
      it 'トップ画像が登録されること' do
        attach_file('site_main_images', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
      end
    end

    context 'トップ画像を複数枚選択してアップロード' do
      it 'トップ画像が複数枚登録されること' do
        attach_file('site_main_images', %w(spec/fixtures/images/runteq_man.jpg spec/fixtures/images/icon.jpg))
        click_on '保存'
        expect(page).to have_selector("img[src$='icon.jpg']")
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
      end
    end

    context 'アップロード済みの画像を削除' do
      it 'トップ画像が削除されること' do
        attach_file('site_main_images', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
        click_on '削除'
        expect(page).not_to have_selector("img[src$='runteq_man.jpg']")
      end
    end
  end

  describe 'favicon画像を変更' do
    context 'favicon画像を１枚選択してアップロード' do
      it 'favicon画像が登録されること' do
        attach_file('site_favicon', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
      end
    end

    context 'アップロード済みのfavicon画像を削除' do
      it 'favicon画像が削除されること' do
        attach_file('site_favicon', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
        click_on '削除'
        expect(page).not_to have_selector("img[src$='runteq_man.jpg']")
      end
    end
  end

  describe 'og_image画像を変更' do
    context 'og_image画像を１枚選択してアップロード' do
      it 'og_image画像が登録されること' do
        attach_file('site_og_image', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
      end
    end

    context 'アップロード済みのog_image画像を削除' do
      it 'og_image画像が削除されること' do
        attach_file('site_og_image', 'spec/fixtures/images/runteq_man.jpg')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.jpg']")
        click_on '削除'
        expect(page).not_to have_selector("img[src$='runteq_man.jpg']")
      end
    end
  end
end