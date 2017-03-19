defmodule Weather.Formatter do

  alias Weather.Report
  # import Enum, only: [join: 2]

  @moduledoc """
  Formats a weather report into a nice looking string.
  """

  @doc """

  Creates format string for a report like this:

  Denton Municipal Airport, TX
  ----------------------------
  Weather:      Fair
  Temperature:  58.0 F (14.4 C)
  Wind:         South at 3.5 MPH (3 KT)
  Pressure:     1020.7 mb
  """
  def format_for(report) do
    with header = format_header(report),
         body = format_body(report) do
         header <> "\n" <> body
    end
  end

  def format_header(%Report{location: location}) do
    location <> "\n" <> String.duplicate("-", String.length(location))
  end

  def format_body(report) do
    """
    Weather:      #{report.weather}
    Temperature:  #{report.temperature}
    Wind:         #{report.wind}
    Pressure:     #{report.pressure}
    """
  end

  def format_and_print(report) do
    report
    |> format_for
    |> IO.puts
  end
end
