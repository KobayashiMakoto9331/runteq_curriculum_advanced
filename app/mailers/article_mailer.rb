class ArticleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.article_mailer.report_summary.subject
  #
  def report_summary
    @published_article_count = Article.published.count
    @articles_published_at_yesterday = Article.published_at_yesterday
    mail(to: 'admin@example.com', subject: '公開済記事の集計結果')
  end
end
