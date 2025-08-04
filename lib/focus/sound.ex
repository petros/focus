defmodule Focus.Sound do
  @moduledoc """
  Cross-platform sound playing functionality for notifications.
  """

  def play_notification do
    case detect_platform() do
      :macos -> play_macos_sound()
      :linux -> play_linux_sound()
      :windows -> play_windows_sound()
      _ -> play_text_notification()
    end
  end

  defp detect_platform do
    case :os.type() do
      {:unix, :darwin} -> :macos
      {:unix, _} -> :linux
      {:win32, _} -> :windows
      _ -> :unknown
    end
  end

  defp play_macos_sound do
    case System.cmd("which", ["afplay"]) do
      {_, 0} ->
        try do
          for _ <- 1..3 do
            System.cmd("afplay", ["/System/Library/Sounds/Glass.aiff"])
            :timer.sleep(500)
          end
        rescue
          _ -> play_text_notification()
        end
      _ ->
        play_text_notification()
    end
  end

  defp play_linux_sound do
    # Try different Linux sound commands in order of preference
    sound_commands = [
      {"paplay", ["/usr/share/sounds/alsa/Front_Right.wav"]},
      {"aplay", ["/usr/share/sounds/alsa/Front_Right.wav"]},
      {"speaker-test", ["-t", "sine", "-f", "1000", "-l", "1"]},
      {"beep", []}
    ]

    case try_sound_commands(sound_commands) do
      :ok -> :ok
      :error -> play_text_notification()
    end
  end

  defp play_windows_sound do
    # Use Windows built-in sound via PowerShell
    try do
      for _ <- 1..3 do
        System.cmd("powershell", ["-c", "[console]::beep(800,300)"])
        :timer.sleep(500)
      end
    rescue
      _ -> play_text_notification()
    end
  end

  defp try_sound_commands([]), do: :error
  defp try_sound_commands([{command, args} | rest]) do
    case System.cmd("which", [command]) do
      {_, 0} ->
        try do
          for _ <- 1..3 do
            System.cmd(command, args)
            :timer.sleep(500)
          end
          :ok
        rescue
          _ -> try_sound_commands(rest)
        end
      _ ->
        try_sound_commands(rest)
    end
  end

  defp play_text_notification do
    IO.puts("🔔 Ding! Ding! Ding! (Timer finished!)")
  end
end