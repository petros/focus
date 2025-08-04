defmodule Focus.Sound do
  @moduledoc """
  Sound playing functionality for macOS notifications.
  """

  def play_notification do
    case System.cmd("which", ["afplay"]) do
      {_, 0} ->
        play_system_sound_multiple_times()
      _ ->
        IO.puts("🔔 Ding! Ding! Ding! (afplay not available)")
    end
  end

  defp play_system_sound_multiple_times do
    try do
      for _ <- 1..3 do
        System.cmd("afplay", ["/System/Library/Sounds/Glass.aiff"])
        :timer.sleep(500)
      end
    rescue
      _ ->
        IO.puts("🔔 Ding! Ding! Ding! (Could not play system sound)")
    end
  end
end