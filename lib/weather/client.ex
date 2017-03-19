defmodule Weather.Client do

  require Logger

  @weather_url "http://w1.weather.gov/xml/current_obs"

  def fetch(station_id) do
    station_id
    |> weather_url
    |> HTTPoison.get
    |> handle_response
  end

  def weather_url(station_id) do
    "#{@weather_url}/#{station_id}.xml"
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    {:ok, body}
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    {:error, body}
  end

end
