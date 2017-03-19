defmodule FormatterTest do
  use ExUnit.Case
  doctest Weather

  import ExUnit.CaptureIO
  import Weather.Formatter
  alias Weather.Report

  def fake_report do
    %Report{
      location:     "Denton Municipal Airport, TX",
      weather:      "Fair",
      temperature:  "58.0 F (14.4 C)",
      pressure:     "1020.7 mb",
      wind:         "South at 3.5 MPH (3 KT)"
    }
  end

  test "format_header" do
    header = format_header(fake_report()) <> "\n"
    assert header == """
    Denton Municipal Airport, TX
    ----------------------------
    """
  end

  test "format_body" do
    body = format_body(fake_report())
    assert body == """
    Weather:      Fair
    Temperature:  58.0 F (14.4 C)
    Wind:         South at 3.5 MPH (3 KT)
    Pressure:     1020.7 mb
    """
  end

  test "format_for" do
    s = format_for(fake_report())
    assert s == """
    Denton Municipal Airport, TX
    ----------------------------
    Weather:      Fair
    Temperature:  58.0 F (14.4 C)
    Wind:         South at 3.5 MPH (3 KT)
    Pressure:     1020.7 mb
    """
  end

  test "format_and_print" do
    result = capture_io fn ->
      format_and_print(fake_report())
    end
    assert result == """
    Denton Municipal Airport, TX
    ----------------------------
    Weather:      Fair
    Temperature:  58.0 F (14.4 C)
    Wind:         South at 3.5 MPH (3 KT)
    Pressure:     1020.7 mb

    """
  end

end

