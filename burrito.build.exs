defmodule Focus.BurritoBuild do
  @moduledoc false

  def build do
    Burrito.wrap(
      "focus",
      platforms: [:darwin_amd64, :darwin_arm64],
      include_erts: true
    )
  end
end