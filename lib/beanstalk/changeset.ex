defmodule Beanstalk.Changeset do
  @moduledoc """
  Manage your commit histories on your Repositories.

  See: http://api.beanstalkapp.com/changeset.html
  """

  @doc """
  Find all Changesets
  """
  def all() do
    Beanstalk.get("changesets.json")
  end

  @doc """
  Find all Changesets (with Pagination)

  Args:
    * `page` (integer) — page number for pagination;
    * `per_page` (integer) — number of elements per page (default 15, maximum 30);
    * `order_field` (string) — what column to use for ordering (default is time);
    * `order` (string) — order direction. Should be either ASC or DESC (default is DESC).
  """
  def all(page, per_page, order_field \\ "time", order \\ "DESC") do
    Beanstalk.get("changesets.json?page=#{page}&per_page=#{per_page}&order_field=#{order_field}&order=#{order}")
  end

  @doc """
  Find all Changesets for Repository

  Args:
    * `repository_id` - repository to find changesets for.
  """
  def repository(repository_id) do
    Beanstalk.get("changesets/repository.json?repository_id=#{repository_id}")
  end

  @doc """
  Find all Changesets for Repository (with Pagination)

  Args:
    * `repository_id` - repository to find changesets for.
    * `page` (integer) — page number for pagination;
    * `per_page` (integer) — number of elements per page (default 15, maximum 30);
    * `order_field` (string) — what column to use for ordering (default is time);
    * `order` (string) — order direction. Should be either ASC or DESC (default is DESC).
  """
  def repository(repository_id, page, per_page, order_field \\ "time", order \\ "DESC") do
    Beanstalk.get("changesets/repository.json?repository_id=#{repository_id}&page=#{page}&per_page=#{per_page}&order_field=#{order_field}&order=#{order}")
  end

  @doc """
  Find Changeset

  Note that revision number is used instead of unique ID, therefore you have to specify repository_id.

  Args:
    * `repository_id` - repository to find changeset on.
    * `revision` - Subversion only. Revision number.
  """
  def find(repository_id, revision) do
    Beanstalk.get("changesets/#{revision}.json?repository_id=#{repository_id}")
  end

  @doc """
  Find Changeset Diffs

  This method will return an array of differences for files of the changeset.
  Each difference is represented as an array of path, status and diff in Unified Diff format.

  Args:
    * `repository_id`
    * `revision`
  """
  def differences(repository_id, revision) do
    Beanstalk.get("changesets/#{revision}/differences.json?repository_id=#{repository_id}")
  end

end
