defmodule XmlParserTest do
  use ExUnit.Case
  doctest Weather

  import Weather.XMLParser
  alias Weather.Report

  def xml_doc do
    """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <current_observation version="1.0"
       xmlns:xsd="http://www.w3.org/2001/XMLSchema"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
      <credit>NOAA's National Weather Service</credit>
      <credit_URL>http://weather.gov/</credit_URL>
      <image>
        <url>http://weather.gov/images/xml_logo.gif</url>
        <title>NOAA's National Weather Service</title>
        <link>http://weather.gov</link>
      </image>
      <suggested_pickup>15 minutes after the hour</suggested_pickup>
      <suggested_pickup_period>60</suggested_pickup_period>
      <location>Denton Municipal Airport, TX</location>
      <station_id>KDTO</station_id>
      <latitude>33.20505</latitude>
      <longitude>-97.20061</longitude>
      <observation_time>Last Updated on Mar 19 2017, 5:53 am CDT</observation_time>
            <observation_time_rfc822>Sun, 19 Mar 2017 05:53:00 -0500</observation_time_rfc822>
      <weather>Fair</weather>
      <temperature_string>58.0 F (14.4 C)</temperature_string>
      <temp_f>58.0</temp_f>
      <temp_c>14.4</temp_c>
      <relative_humidity>100</relative_humidity>
      <wind_string>South at 3.5 MPH (3 KT)</wind_string>
      <wind_dir>South</wind_dir>
      <wind_degrees>160</wind_degrees>
      <wind_mph>3.5</wind_mph>
      <wind_kt>3</wind_kt>
      <pressure_string>1020.7 mb</pressure_string>
      <pressure_mb>1020.7</pressure_mb>
      <pressure_in>30.16</pressure_in>
      <dewpoint_string>57.9 F (14.4 C)</dewpoint_string>
      <dewpoint_f>57.9</dewpoint_f>
      <dewpoint_c>14.4</dewpoint_c>
      <visibility_mi>8.00</visibility_mi>
      <icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
      <two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
      <icon_url_name>nskc.png</icon_url_name>
      <ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
      <disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
      <copyright_url>http://weather.gov/disclaimer.html</copyright_url>
      <privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
    </current_observation>
    """
  end

  test "parse_location" do
    report = parse_location(%Report{}, xml_doc())
    assert report.location == "Denton Municipal Airport, TX"
  end

  test "parse_weather" do
    report = parse_weather(%Report{}, xml_doc())
    assert report.weather == "Fair"
  end

  test "parse_temp" do
    report = parse_temp(%Report{}, xml_doc())
    assert report.temperature == "58.0 F (14.4 C)"
  end

  test "parse_wind" do
    report = parse_wind(%Report{}, xml_doc())
    assert report.wind == "South at 3.5 MPH (3 KT)"
  end

  test "parse_pressure" do
    report = parse_pressure(%Report{}, xml_doc())
    assert report.pressure == "1020.7 mb"
  end

  test "parse_xml" do
    report = parse_xml(xml_doc())
    assert report == %Report{
      location:     "Denton Municipal Airport, TX",
      weather:      "Fair",
      temperature:  "58.0 F (14.4 C)",
      pressure:     "1020.7 mb",
      wind:         "South at 3.5 MPH (3 KT)"
    }
  end

end


