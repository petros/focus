defmodule Focus.CLI do
  @moduledoc """
  Command line interface for the Focus timer.
  """

  @default_work_minutes 25
  @default_break_minutes 5

  def main(args) do
    {minutes, _} = parse_args(args)
    Focus.Timer.start_countdown(minutes)
  end

  defp parse_args([]), do: {@default_work_minutes, :work}
  defp parse_args(["work"]), do: {@default_work_minutes, :work}
  defp parse_args(["break"]), do: {@default_break_minutes, :break}
  defp parse_args([minutes_str]) do
    case Integer.parse(minutes_str) do
      {minutes, ""} when minutes >= 1 and minutes <= 120 ->
        {minutes, :custom}
      _ ->
        IO.puts("Error: Please provide a number between 1 and 120")
        System.halt(1)
    end
  end
  defp parse_args(_) do
    IO.puts("Usage: focus [work|break|<minutes>]")
    System.halt(1)
  end
end