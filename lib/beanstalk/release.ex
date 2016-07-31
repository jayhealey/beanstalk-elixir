defmodule Beanstalk.Release do
  @moduledoc """
  Manage releases for your Repositories.

  See: http://api.beanstalkapp.com/release.html
  """

  @doc """
  Returns a list of all releases for the Beanstalk account.
  """
  def all() do
    Beanstalk.get("releases.json")
  end

  @doc """
  Returns a paginated list of releases within your Beanstalk account.

  Set the page number and per page.

  Args:
    * `page` - page number for pagination.
    * `per_page` - number of elements per page (default 30, maximum 50).
  """
  def all(page, per_page) do
    Beanstalk.get("releases.json?page=#{page}&per_page=#{per_page}")
  end

  @doc """
  Returns a list of releases for the given repository.

  Args:
    * `repository_id` - repository to find releases for.
  """
  def repository(repository_id) do
    Beanstalk.get("#{repository_id}/releases.json")
  end

  @doc """
  Returns a paginated list of releases for the given repository.

  Args:
    * `repository_id` - repository to find releases for.
    * `page` - page number for pagination.
    * `per_page` - number of elements per page (default 30, maximum 50).
  """
  def repository(repository_id, page, per_page) do
    Beanstalk.get("#{repository_id}/releases.json?page=#{page}&per_page=#{per_page}")
  end

  @doc """
  Creating a release means requesting a deployment.

  If you already have some releases in state “new” or “retry”, Beanstalk will delete them after creating a new one.

  Args:
    * `repository_id` - repository to create the release on.
    * `server_environment_id` - server environment to use.
    * `comment` - comment for the release.
    * `revision` - specific commit to release.
    * `deploy_from_scratch` - deploy from the first revision rather then doing incremental deployment.
    * `do_not_notify` -  do not trigger email notification for this deployment.
  """
  def create(repository_id, server_environment_id, comment, revision, deploy_from_scratch \\ false, do_not_notify \\ false) do

    parameters = [
      release: [
        comment: comment,
        revision: revision,
        deploy_from_scratch: deploy_from_scratch,
        do_not_notify: do_not_notify
      ]
    ]

    Beanstalk.post("#{repository_id}/releases.json?environment_id=#{server_environment_id}", parameters)
  end

  @doc """
  Use this method to retry a failed deployment.

  Args:
    * `repository_id` - repository to retry the release on.
    * `release_id` - release to retry.
  """
  def retry(repository_id, release_id) do
    Beanstalk.get("#{repository_id}/releases/#{release_id}/retry.json")
  end
end
