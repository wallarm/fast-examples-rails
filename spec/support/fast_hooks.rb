RSpec.configure do |config|
  config.include FastHelper, type: :feature

  config.before :context, type: :feature do
    create_test_run
  end

  config.after :context, type: :feature do
    stop_test_record
    wait_test_run_for_finish
  end
end
