defmodule BeanstalkTest do
  use ExUnit.Case
  doctest Beanstalk

  setup do
    Application.put_env(:beanstalk, :account, "fake-account")
    Application.put_env(:beanstalk, :username, "fake-username")
    Application.put_env(:beanstalk, :password, "fake-password!")
  end

  test "application should start" do
    {result, _} = Beanstalk.start
    assert result == :ok
  end

  test "url processor includes configurable account and given end-point" do
    assert Beanstalk.process_url("my-end-point.json") == "https://fake-account.beanstalkapp.com/api/my-end-point.json"
  end

  test "process_response_body decodes json" do
    assert Beanstalk.process_response_body("{'ok':true}") == {:ok, %{"ok" => true}}
  end

  test "account is configurable" do
    assert Beanstalk.account == "fake-account"
  end

  test "username is configurable" do
    assert Beanstalk.username == "fake-username"
  end

  test "password is configurable" do
    assert Beanstalk.password == "fake-password!"
  end

end
