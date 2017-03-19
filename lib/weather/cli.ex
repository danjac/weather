defmodule Weather.CLI do
  @moduledoc """
  Handle the command line parsing and dispatch to various functions
  """

  import Weather.Client, only: [fetch: 1]
  import Weather.XMLParser, only: [parse_xml: 1]
  import Weather.Formatter, only: [format_and_print: 1]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or help, which returns :help.
  Otherwise should be the station ID e.g. KDTO (case insensitive)
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ station_id ], _ } -> station_id
      _                        -> :help
    end

  end

  def process(:help) do
    IO.puts """
    usage: weather <station_id>
    example: weather KDTO
    """
  end

  def process(station_id) do
    case String.upcase(station_id) |> fetch do
      {:ok, body} ->
        body
        |> parse_xml
        |> format_and_print
      {:error, _} -> System.halt(2)
    end
  end
end
