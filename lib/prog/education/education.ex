defmodule Prog.Education do
  alias Prog.Repo
  alias Prog.Education.Video

  def create_video(attributes) do
    Video.changeset(%Video{}, attributes)
    |> Repo.insert()
  end
end