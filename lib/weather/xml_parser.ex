defmodule Weather.XMLParser do
  @moduledoc """
  Parses the raw XML data into a weather report struct.
  """
  import SweetXml
  alias Weather.Report

  def parse_xml(doc) do
    %Report{}
    |> parse_location(doc)
    |> parse_weather(doc)
    |> parse_temp(doc)
    |> parse_wind(doc)
    |> parse_pressure(doc)
  end

  def parse_location(report, doc),
    do: parse_data(report, doc, :location, "location")

  def parse_weather(report, doc),
    do: parse_data(report, doc, :weather, "weather")

  def parse_wind(report, doc),
    do: parse_data(report, doc, :wind, "wind_string")

  def parse_temp(report, doc),
    do: parse_data(report, doc, :temperature, "temperature_string")

  def parse_pressure(report, doc),
    do: parse_data(report, doc, :pressure, "pressure_string")

  defp parse_data(report, doc, field, xml_element) do
    with value = doc |> xpath(~x"//#{xml_element}/text()") do
      Map.put(report, field, to_string(value))
    end
  end
end
