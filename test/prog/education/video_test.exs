defmodule Prog.Education.VideoTest do
  use Prog.DataCase
  alias Prog.Education

  test "create_video/1 - creates a record with valid attrs" do
    {:ok, video} = Education.create_video(%{
      "title" => "My first video",
      "description" => "This is an interesting video",
      "youtube_url" => "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    })

    assert video.id
    assert video.title       == "My first video"
    assert video.slug        == "my-first-video"
    assert video.description == "This is an interesting video"
    assert video.youtube_url == "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  end

  test "create_video/1 - validates title and description" do
    {:error, changeset} = Education.create_video(%{
      "title" => "",
      "description" => "",
    })

    assert changeset.errors[:title]
    assert changeset.errors[:description]
  end

  test "create_video/1 - validates slug is unique" do
    {:ok, _video} = Education.create_video(%{
      "title" => "My first video",
      "description" => "This is a description",
    })

    {:error, changeset} = Education.create_video(%{
      "title" => "My first video",
      "description" => "This is a description",
    })

    assert changeset.errors[:slug]
  end
end