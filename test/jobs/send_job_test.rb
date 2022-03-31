require "test_helper"

class SendJobTest < ActiveJob::TestCase
  uri = "https://yandex.ru/news/"
  msg = "same message"

  # проверка постановки в очередь
  test "queue check" do
    SendJob.perform_now(uri, msg)
    assert_enqueued_jobs 0
    SendJob.perform_later(uri, msg)
    assert_enqueued_jobs 1
    SendJob.perform_later(uri, msg)
    assert_enqueued_jobs 2
  end
end
