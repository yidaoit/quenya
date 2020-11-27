defmodule Quenya.MixProject do
  use Mix.Project

  def project do
    [
      app: :quenya,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Quenya.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp rustler_crates do
    [
      oas: [
        path: "native/oas",
        mode: rustc_mode(Mix.env())
      ]
    ]
  end

  defp rustc_mode(:prod), do: :release
  defp rustc_mode(_), do: :debug

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dynamic_module, "~> 0.1"},
      {:rustler, "~> 0.22.0-rc.0"},
      {:yaml_elixir, "~> 2.5"},
      {:jason, "~> 1.2"},
      {:deep_merge, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:recase, "~> 0.7"},
      {:ex_json_schema, "~> 0.7"},
      {:quenya_util, path: "../quenya_util"}
    ]
  end
end