class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    @article.published_at = Time.current unless @article.published_at?
    @article.state = @article.publishable? ? :published : :publish_wait

    if @article.valid?
      Article.transaction do
        # @article.body = @article.build_body(self)
        @article.save!
      end
      flash[:notice] = @article.message_on_published
      redirect_to edit_admin_article_path(@article.uuid)
    else

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end
end
