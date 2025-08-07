defmodule Focus.Timer do
  @moduledoc """
  Timer functionality for the Focus app.
  """

  def start_countdown(minutes) do
    total_seconds = minutes * 60
    IO.puts("Starting #{minutes} minute focus session...")
    IO.puts("Press Ctrl+C to exit")
    IO.puts("")
    
    countdown(total_seconds)
    
    IO.puts("\n🎉 Time's up!")
    Focus.Sound.play_notification()
    
    # Properly terminate the application for CLI usage
    System.halt(0)
  end

  defp countdown(0) do
    IO.write(:stdio, "\r00:00")
  end

  defp countdown(seconds) do
    minutes = div(seconds, 60)
    remaining_seconds = rem(seconds, 60)
    
    IO.write(:stdio, "\r#{format_time(minutes)}:#{format_time(remaining_seconds)}")
    
    :timer.sleep(1000)
    countdown(seconds - 1)
  end

  defp format_time(time) when time < 10, do: "0#{time}"
  defp format_time(time), do: "#{time}"
end