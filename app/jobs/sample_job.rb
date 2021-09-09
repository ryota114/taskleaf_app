class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sidekiq::Logging.logger.info "サンプルジョブを実行しました"
  end
end
