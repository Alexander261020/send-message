require "test_helper"

class ScheduleJobTest < ActiveJob::TestCase
  uri = "https://yandex.ru/news/"

  # проверяем количество задач в очереди
  test "check the number of tasks in the queue" do
    assert_enqueued_jobs 0
    ScheduleJob.perform_later(1, 2, uri)
    assert_enqueued_jobs 1
    ScheduleJob.perform_later(1, 2, uri)
    assert_enqueued_jobs 2
    ScheduleJob.perform_later(1, 2, uri)
  end

  # проверка количества поставленных в очередь задач SendJob через ScheduleJob
  test "checking the number of queued tasks SendJob across ScheduleJob" do
    ScheduleJob.perform_now(0, 1, uri)
    assert_enqueued_jobs 0
    ScheduleJob.perform_now(3, 1, uri)
    assert_enqueued_jobs 3, only: SendJob
    ScheduleJob.perform_now(7, 1, uri)
    assert_enqueued_jobs 10, only: SendJob
  end

  # постановка с заданными аргументами
  test "statement with given arguments" do
    ScheduleJob.perform_later(3, 1, uri)
    assert_enqueued_with(job: ScheduleJob, args: [3, 1, uri])

    ScheduleJob.set(wait_until: Date.tomorrow.noon).perform_later
    assert_enqueued_with(at: Date.tomorrow.noon)
  end
end
