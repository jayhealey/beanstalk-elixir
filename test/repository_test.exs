  defmodule Beanstalk.RepositoryTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/repositories")
    Beanstalk.start()
    :ok
  end

  test "list all repositories" do
    use_cassette "list_all_repositories" do
      {status, _} = Beanstalk.Repository.all
      assert status == :ok
    end
  end

  test "list all repositories paginated" do
    use_cassette "list_all_repositories_paginated" do
      {status, _} = Beanstalk.Repository.all(2, 3)
      assert status == :ok
    end
  end

  test "find repository" do
    use_cassette "find_repository" do
      {status, _} = Beanstalk.Repository.find(708090)
      assert status == :ok
    end
  end

  test "find repository is missing" do
    use_cassette "find_repository_missing" do
      {status, message} = Beanstalk.Repository.find(654789)
      assert status == :error
      assert message == "Repository Not Found"
    end
  end

  test "create new repository" do
    use_cassette "create_new_repository" do
      {status, _} = Beanstalk.Repository.create("test-project", "Test Project", "label-green")
      assert status == :ok
    end
  end

  test "create new repository reaching limit" do
    use_cassette "create_new_repository_reaching_limit" do
      {status, _} = Beanstalk.Repository.create("another-test-project", "Another Test Project", "label-green")
      assert status == :error
    end
  end

  test "update repository" do
    use_cassette "update_repository" do
      {status, _} = Beanstalk.Repository.update(708090, "another-test-project-updated", "Another Test Project Updated", "label-green")
      assert status == :ok
    end
  end

  test "update missing repository" do
    use_cassette "update_missing_repository" do
      {status, message} = Beanstalk.Repository.update(654789, "another-test-project", "Another Test Project", "label-green")
      assert status == :error
      assert message == "Repository Not Found"
    end
  end

  test "rename repository" do
    use_cassette "rename_repository" do
      {status, _} = Beanstalk.Repository.rename(708090, "renamed-test-project", "Renamed Test Project")
      assert status == :ok
    end
  end

  test "rename missing repository" do
    use_cassette "rename_missing_repository" do
      {status, message} = Beanstalk.Repository.rename(654789, "renamed-test-project", "Renamed Test Project")
      assert status == :error
      assert message == "Repository Not Found"
    end
  end

  test "delete repository" do
    use_cassette "delete_repository" do
      {status, response} = Beanstalk.Repository.delete(708090)
      assert status == :ok
      assert response == :empty
    end
  end

  test "delete missing repository" do
    use_cassette "delete_missing_repository" do
      {status, message} = Beanstalk.Repository.delete(654789)
      assert status == :error
      assert message == "Repository Not Found"
    end
  end

end
