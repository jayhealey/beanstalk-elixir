defmodule Beanstalk.Repository do
  @moduledoc """
  Manage your repositories.

  See: http://api.beanstalkapp.com/repository.html
  """

  @doc """
  Returns a full list of repositories within your Beanstalk account.
  """
  def all() do
    Beanstalk.get("repositories.json")
  end

  @doc """
  Returns a paginated list of repositories within your Beanstalk account.

  Set the page number and per page.

  Args:
    * `page` - page number for pagination.
    * `per_page` - number of elements per page (default 30, maximum 50).
  """
  def all(page, per_page) do
    Beanstalk.get("repositories.json?page=#{page}&per_page=#{per_page}")
  end

  @doc """
  Returns a single repository matching the given `repository_id`.

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
  """
  def find(repository_id) do
    Beanstalk.get("repositories/#{repository_id}.json")
  end

  @doc """
  Returns an array of repository’s branches.

  For Subversion always returns an empty array.

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
  """
  def branches(repository_id) do
    Beanstalk.get("repositories/#{repository_id}/branches.json")
  end

  @doc """
  Returns an array of repository’s tags.

  For Subversion always returns an empty array

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
  """
  def tags(repository_id) do
    Beanstalk.get("repositories/#{repository_id}/tags.json")
  end

  @doc """
  Create a new repository

  Args:
    * `name` - this is the slug (e.g. `my-repository`) of the repository.
    * `title` - the title of the repository (e.g. 'My Repository').
    * `color_label` - name of the specified color label. See Beanstalk documentation for full list.
    * `type_id` - Type of repostory. Choices are `git` or `subversion`. Default is `git`.
  """
  def create(name, title, color_label, type_id \\ "git") do
    parameters = [
      repository: [
        type_id: type_id,
        name: name,
        title: title,
        color_label: color_label
      ]
    ]

    Beanstalk.post("repositories.json", parameters)
  end

  @doc """
  Update an existing repository

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
    * `name` - this is the slug (e.g. `my-repository`) of the repository.
    * `title` - the title of the repository (e.g. 'My Repository').
    * `color_label` - name of the specified color label. See Beanstalk documentation for full list.
    * `type_id` - Type of repostory. Choices are `git` or `subversion`. Default is `git`.
  """
  def update(repository_id, name, title, color_label, type_id \\ "git") do

    parameters = [
      repository: [
        repository_id: repository_id,
        name: name,
        title: title,
        color_label: color_label,
        type_id: type_id
      ]
    ]

    Beanstalk.put("repositories/#{repository_id}.json", parameters)
  end

  @doc """
  Rename a repository.

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
    * `name` - this is the slug (e.g. `my-repository`) of the repository.
    * `title` - the title of the repository (e.g. 'My Repository').
  """
  def rename(repository_id, name, title) do
    parameters = [
      repository: [
        name: name,
        title: title
      ]
    ]

    Beanstalk.put("repositories/#{repository_id}/rename.json", parameters)
  end

  @doc """
  Delete a repository

  Args:
    * `repository_id` - The `id` attribute from the `repository` object.
  """
  def delete(repository_id) do
    Beanstalk.delete("repositories/#{repository_id}.json")
  end

end
