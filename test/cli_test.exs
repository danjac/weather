defmodule CliTest do
  use ExUnit.Case
  doctest Weather

  import Weather.CLI, only: [ parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do

    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["", ""]) == :help

  end

  test "parses station id" do
    assert parse_args(["KDTO"]) == "KDTO"
  end

end
