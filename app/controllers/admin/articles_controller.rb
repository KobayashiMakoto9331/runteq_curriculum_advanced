class Admin::ArticlesController < ApplicationController
  layout 'admin'

  before_action :set_article, only: %i[edit update destroy]

  def index
    authorize(Article)

    @search_articles_form = SearchArticlesForm.new(search_params)
    @articles = @search_articles_form.search.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @article = Article.new
  end

  def create
    authorize(Article)

    @article = Article.new(article_params)
    @article.state = :draft

    if @article.save
      redirect_to edit_admin_article_path(@article.uuid)
    else
      render :new
    end
  end

  def edit
    authorize(@article)
  end

  def update
    authorize(@article)

    if @article.update(article_params)
      if @article.state == 'draft' # 下書きならそのまま
        @article.draft!
        flash[:notice] = '更新しました'
      elsif Time.current >= @article.published_at # 現在時刻が公開日より後なら、公開に変更
        @article.published!
        flash[:notice] = '記事を公開しました'
      elsif Time.current < @article.published_at # 公開日が未来になっているのは、公開待ち
        @article.publish_wait!
        flash[:notice] = '記事を公開待ちにしました'
      end

      redirect_to edit_admin_article_path(@article.uuid)
    else
      render :edit
    end
  end

  def destroy
    authorize(@article)

    @article.destroy

    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(
      :title, :description, :slug, :state, :published_at, :eye_catch, :category_id, :author_id, tag_ids: []
    )
  end

  def search_params
    params[:q]&.permit(:title, :category_id)
  end

  def set_article
    @article = Article.find_by!(uuid: params[:uuid])
  end
end
