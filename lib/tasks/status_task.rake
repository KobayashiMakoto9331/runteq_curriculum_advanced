namespace :status_task do

  desc "公開待ちの中で、公開日時が過去になっているものがあれば、ステータスを「公開」に変更する"
  task update_status_task: :environment do
    Article.publish_wait.post_published.find_each(&:published!)
    # puts '通った？'
  end

end
