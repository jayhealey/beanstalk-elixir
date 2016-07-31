defmodule Beanstalk.User do

  @moduledoc """
  Manage user accounts within Beanstalk.

  See: http://api.beanstalkapp.com/user.html
  """

  @doc """
  Returns a full list of users within your Beanstalk account.
  """
  def all() do
    Beanstalk.get("users.json")
  end

  @doc """
  Returns a paginated list of users within your Beanstalk account.

  Set the page number and per page.

  Args:
    * `page` - page number for pagination.
    * `per_page` - number of elements per page (default 30, maximum 50).
  """
  def all(page, per_page) do
    Beanstalk.get("users.json?page=#{page}&per_page=#{per_page}")
  end

  @doc """
  Returns a single user matching the given `user_id`.

  Args:
    * `user_id` - The `id` attribute from the `user` object (not `account_id`).
  """
  def find(user_id) do
    Beanstalk.get("users/#{user_id}.json")
  end

  @doc """
  Returns currently logged in user (that is: the user you configured for module).
  """
  def current() do
    Beanstalk.get("users/current.json")
  end

  @doc """
  Create new user.

  _Admin privileges required for this API method._

  Args:
    * `login` - Username. Unique per Account.
    * `email` - Email address. Unique per account.
    * `name` - Full name.
    * `password` - Required on create.
    * `timezone` - Optional.
    * `admin` - Boolean value. Optional. Default is `false.`
  """
  def create(login, email, name, password, timezone \\ "", admin \\ false) do
    parameters = [
      user: [
        login: login,
        email: email,
        name: name,
        password: password,
        admin: admin,
        timezone: timezone
      ]
    ]

    Beanstalk.post("users.json", parameters)
  end

  @doc """
  Update the given user.

  _Admin privileges required for this API method._

  Args:
    * `user_id` - The `id` attribute from the `user` object (not `account_id`).
    * `login` - Username. Unique per Account.
    * `email` - Email address. Unique per account.
    * `name` - Full name.
    * `password` - Required on create.
    * `timezone` - Optional.
    * `admin` - Boolean value. Optional. Default is `false.`
  """
  def update(user_id, login, email, name, password, timezone \\ "", admin \\ false) do
    parameters = [
      user: [
        login: login,
        email: email,
        name: name,
        password: password,
        admin: admin,
        timezone: timezone
      ]
    ]

    Beanstalk.put("users/#{user_id}.json", parameters)
  end

  @doc """
  Delete the given user.

  Admin privileges required for this API method.

  You can not delete account owner.

  Args:
    * `user_id` - The `id` attribute from the `user` object (not `account_id`).
  """
  def delete(user_id) do
    Beanstalk.delete("users/#{user_id}.json")
  end

end
