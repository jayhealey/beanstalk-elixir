defmodule Beanstalk do
  @moduledoc false

  use Application
  use HTTPoison.Base

  def start(_type, _args) do
    Beanstalk.Supervisor.start_link
  end

  def process_url(endpoint) do
    super("https://" <> account() <> ".beanstalkapp.com/api/" <> endpoint)
  end

  defp process_request_headers([]) do
    # Set the default headers required for Beanstalk
    Map.new
    |> Map.put('Content-Type', 'application/json')
    |> Map.put('Accept', 'application/json')
    |> Map.to_list
  end

  def process_request_body(body) do
    JSX.encode!(body)
  end

  def process_response_body(body) do
    JSX.decode(body)
  end

  defp request(method, url, body, headers, options) do
    # Attach the authentication required by Beanstalk
    options = Enum.concat([hackney: [basic_auth: { username(), password() }]], options)

    super(method, url, body, headers, options)
  end

  def get(url) do
    super(url)
      |> parse_response
  end

  def post(url, parameters) do
    super(url, parameters)
      |> parse_response
  end

  def put(url, parameters) do
    super(url, parameters)
      |> parse_response
  end

  def patch(url, parameters) do
    super(url, parameters)
      |> parse_response
  end

  def delete(url) do
    super(url)
      |> parse_response
  end

  defp parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code, body: {:error, :badarg}}} when status_code in 200..299 ->
        {:ok, :empty}

      {:ok, %HTTPoison.Response{status_code: status_code} = response } when status_code in 200..201 ->
        response.body

      {:ok, %HTTPoison.Response{status_code: status_code} = response } when status_code in 202..299 ->
        {:ok, response.body}

      {:ok, %HTTPoison.Response{status_code: status_code} = response } when status_code in 400..599 ->
        {:error, get_error_messages(response.body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, get_error_messages(reason)}
    end
  end

  defp get_error_messages(error) do
    case error do
      "timeout" ->
        "The end-point timed out. This could mean the resource you're looking for couldn't be found. Did you supply the right parameters?"
      :timeout ->
        "The end-point timed out. This could mean the resource you're looking for couldn't be found. Did you supply the right parameters?"
      {:ok, %{"error" => error}} ->
        error
      {:ok, %{"errors" => errors}} ->
        to_string(errors)
    end
  end

  def account do
    Application.get_env(:beanstalk, :account) ||
      System.get_env(:beanstalk_account)
  end

  def username do
    Application.get_env(:beanstalk, :username) ||
      System.get_env(:beanstalk_username)
  end

  def password do
    Application.get_env(:beanstalk, :password) ||
      System.get_env(:beanstalk_password)
  end

end
