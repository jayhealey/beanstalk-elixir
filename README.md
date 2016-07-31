# Beanstalk-Elixir
### An HTTP client for the Beanstalk API written in Elixir.

Beanstalk is for hosting and deployment of code: https://beanstalkapp.com

The API documentation can be found here: http://api.beanstalkapp.com

Full details about the level of API coverage is <a href="https://hexdocs.pm/beanstalk/0.1.0/api-reference.html">explained in the documentation</a>.

----

## Installation

It's available on Hex.pm, so it can be installed by:

  1. Add beanstalk to your list of dependencies in `mix.exs`:

        def deps do
          [{:beanstalk, "~> 0.1.0"}]
        end

  2. Ensure beanstalk is started before your application:

        def application do
          [applications: [:beanstalk]]
        end

  3. In your `config/config.exs`, add the following and set your Beanstalk settings:

        config :beanstalk,
          account: "account-name",
          username: "username",
          password: "password"


The `account` is the sub-domain you use to access Beanstalk. If the URL is `http://company.beanstalkapp.com`, then your account is `company`.

The `username` and `password` are the user account you want to use to access the API.

_It's advisable to create an account specifically for using the API, and set the access levels you require for your needs instead of using your own account._

---

## Making calls

Firstly, start the module, and then call the end-point...

```
{:ok, response} = Beanstalk.User.all

{:ok,
 [%{"user" => %{
 	"account_id" => 123456,
 	"admin" => false,
      "can_create_repos" => false,
      "created_at" => "2016/07/10 12:50:25 +1000",
      "email" => "test@test.com",
      "first_name" => "Test",
      "id" => 654321,
      "last_name" => "Test",
      "login" => "fake-username",
      "name" => "Test Test",
      "owner" => true,
      "timezone" => "Melbourne",
      "updated_at" => "2016/07/23 16:37:11 +1000"
    }
  }
]}
```

See the <a href="https://hexdocs.pm/beanstalk/0.1.0/readme.html">documentation for full details</a> of all the end-points.

---

## Handling responses

The core `Beanstalk` module handles the response, so you don't have to worry about HTTP status codes, JSON decoding or error trapping - that's all done for you.

All you need to do is pattern match the following tuples.

### Successful response

The most common response is the successful one...

```
{:ok, response} => ...
```

`:ok` indicates a successful call.

`response` is the result body, decoded from JSON (using `JSX.decode`) to a Map.

### Empty (but successful) response

This will only occur when calling an end-point that uses `update` or `delete`.

This is because the body of the response will be empty - but it's still a successful response.

```
{:ok, :empty} => ...
```

`:ok` indicates a successful call.

`:empty` indicates an empty body.

### Failure response

In the case the call fails, by means of bad parameters or bad response:

```
{:error, message} => ...
```

`:error` indicates an error occurred making the call.

`message` is a string containing all of the error messages returned by Beanstalk.

----

### As an aside...

All of the end-point modules rely on the core `Beanstalk` module, and it's unlikely you'll ever call the `Beanstalk` module directly (unless of course you want to contribute?).

As the `Beanstalk` module uses `HTTPoison`, the generated documentation quickly became confusing and added nothing to this module.

So whilst it's core of this plugin, documentation for it has been disabled - but it is commented.

Any ideas, pull requests or feedback welcome.

----

## Coverage

The following end-points are covered with documentation:

&#x2713; Changeset<br>
&#x2713; Release (require tests)<br>
&#x2713; Repository<br>
&#x2713; User

The following need coverage:

&#x2717; Account<br>
&#x2717; Code Reviews (Comments, Events, Assignees, Watchers, Settings)<br>
&#x2717; Comment<br>
&#x2717; Feed Key<br>
&#x2717; Invitation<br>
&#x2717; Integration<br>
&#x2717; Node<br>
&#x2717; Public Key<br>
&#x2717; Repository Import<br>
&#x2717; Permissions<br>
&#x2717; Plan<br>
&#x2717; Release Server<br>
&#x2717; Server Environment<br>
&#x2717; Team<br>
