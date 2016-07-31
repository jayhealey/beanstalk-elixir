defmodule Beanstalk.Mixfile do
  use Mix.Project

  def project do
    [
      app: :beanstalk,
      name: "Beanstalk HTTP client",
      description: "An HTTP client for the Beanstalk API written in Elixir.",
      maintainers: "James Healey (jayhealey@gmail.com)",
      deps: deps(),
      package: package(),
      source_url: "https://github.com/jayhealey/beanstalk-elixir",
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      docs: [extras: ["README.md"]]
    ]
  end

  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:dev), do: applications(:all) ++ [:remix]
  defp applications(_all), do: [:logger, :httpoison, :exjsx]

  defp package do
    [
      name: :beanstalk,
      maintainers: ["James Healey"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/jayhealey/beanstalk-elixir",
        "Twitter" => "https://twitter.com/jayhealey"
      }
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:exjsx, "~> 3.2", app: false},
      {:apex, "~>0.5.0", only: :dev},
      {:ex_doc, "~> 0.12", only: :dev},
      {:mock, "~> 0.1.1", only: :test},
      {:exvcr, "~> 0.7", only: :test},
      {:remix, "~> 0.0.1", only: :dev}
    ]
  end
end
