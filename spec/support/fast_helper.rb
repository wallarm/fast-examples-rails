class String
  def green; "\e[32m#{self}\e[0m" end
  def red;   "\e[31m#{self}\e[0m" end
end

module FastHelper
  TEST_RUN_FINAL_STATES = %w[failed passed interrupted].freeze

  def create_test_run
    url = "https://#{ENV['WALLARM_API_HOST']}/v1/test_run"

    response = RestClient.post url, test_run_params, auth_headers

    resp_body = JSON.parse(response.body)['body']

    @test_run_id    = resp_body['id']
    @test_record_id = resp_body['test_record_id']

    sleep 1 until current_test_run['node_active']

    # TODO: check for FAST node started recordind baselines
    sleep 8
  end

  def stop_test_record
    # TODO: check for FAST node exported all recorded baselined
    sleep 8

    url = "https://#{ENV['WALLARM_API_HOST']}/v1/test_record/#{@test_record_id}/action/stop"

    RestClient.post url, {}, auth_headers
  end

  def current_test_run
    url = "https://api.wallarm.com/v1/test_run/#{@test_run_id}"

    response  = RestClient.get url, auth_headers
    resp_body = JSON.parse(response.body)['body']
    resp_body
  end

  def wait_test_run_for_finish
    sleep 1 until TEST_RUN_FINAL_STATES.include?(current_test_run['state'])

    test_run = current_test_run

    puts
    case current_test_run['state']
    when 'failed'
      puts 'FAST tests are failed'.red
      exit 1
    when 'interrupted'
      puts 'FAST tests are interrupted'.red
      exit 1
    when 'passed'
      puts 'FAST tests are passed'.green
    end
  end

  private

  def auth_headers
    {
      'X-WallarmApi-Token' => ENV['WALLARM_API_TOKEN']
    }
  end

  def test_run_params
    {
      'name' => 'FAST Rails example',
      'desc' => 'rails, rspec, capybara example',
      'type' => 'node'
    }
  end
end
