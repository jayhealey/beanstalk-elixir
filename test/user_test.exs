defmodule Beanstalk.UserTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/users")
    Beanstalk.start()
    :ok
  end

  test "list all users" do
    use_cassette "list_all_users" do
      {status, response} = Beanstalk.User.all
      assert status == :ok
      assert Enum.any?(response, fn (users) -> 123456 == users["user"]["id"] end)
    end
  end

  test "list all users paginated" do
    use_cassette "list_all_users_paginated" do
      {status, _} = Beanstalk.User.all(2,3)
      assert status == :ok
    end
  end

  test "find user" do
    use_cassette "find_user" do
      {status, response} = Beanstalk.User.find(123456)
      assert status == :ok
      assert response["user"]["id"] == 123456
    end
  end

  test "find missing user" do
    use_cassette "find_missing_user" do
      {status, message} = Beanstalk.User.find(123456)
      assert status == :error
      assert message == "Could not find User."
    end
  end

  test "get current user" do
    use_cassette "get_current_user" do
      {status, response} = Beanstalk.User.current
      assert status == :ok
      assert response["user"]["id"] == 123456
    end
  end

  test "create new user" do
    use_cassette "create_new_user" do
      {status, response} = Beanstalk.User.create("test", "test@test.com", "testing tester", "testing321!", "Melbourne")
      assert status == :ok
      assert Map.has_key?(response, "user")
    end
  end

  test "create new user reaching limit" do
    use_cassette "create_new_user_reaching_limit" do
      {status, message} = Beanstalk.User.create("test", "test@test.com", "testing tester", "testing321!", "Melbourne")
      assert status == :error
      assert message == "You reached limit of users"
    end
  end

  test "update user" do
    use_cassette "update_user" do
      {status, response} = Beanstalk.User.update(321654, "testupdate", "test@testupdate.com", "testing updater", "testing321!", "Melbourne")
      assert status == :ok
      assert response == :empty
    end
  end

  test "delete missing user" do
    use_cassette "delete_missing_user" do
      {status, message} = Beanstalk.User.delete(123456)
      assert status == :error
      assert message == "Could not find User."
    end
  end

  test "delete user" do
    use_cassette "delete_user" do
      {status, response} = Beanstalk.User.delete(321654)
      assert status == :ok
      assert response == :empty
    end
  end

end
