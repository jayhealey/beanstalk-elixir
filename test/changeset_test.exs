defmodule Beanstalk.ChangesetTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/changesets")
    Beanstalk.start()
    :ok
  end

  test "list all changesets" do
    use_cassette "list_all_changesets" do
      {status, _} = Beanstalk.Changeset.all()
      assert status == :ok
    end
  end

  test "list all changesets paginated" do
    use_cassette "list_all_changesets_paginated" do
      {status, _} = Beanstalk.Changeset.all(1,1, "time", "ASC")
      assert status == :ok
    end
  end

  test "find repository changesets" do
    use_cassette "find_repository_changesets" do
      {status, _} = Beanstalk.Changeset.repository(654123)
      assert status == :ok
    end
  end

  test "find missing repository changesets" do
    use_cassette "find_missing_repository_changesets" do
      {status, _} = Beanstalk.Changeset.repository(98765)
      assert status == :error
    end
  end

  test "find revision in repository" do
    use_cassette "find_revision_in_repository" do
       {status, _} = Beanstalk.Changeset.find(654123, "c20f133d")
       assert status == :ok
    end
  end

  test "find missing revision in repository" do
    use_cassette "find_missing_revision_in_repository" do
       {status, _} = Beanstalk.Changeset.find(123456, "c20f133d")
       assert status == :error
    end
  end

  test "find revision in missing repository " do
    use_cassette "find_revision_in_missing_repository" do
       {status, _} = Beanstalk.Changeset.find(654123, "abcdef03")
       assert status == :error
    end
  end

end
