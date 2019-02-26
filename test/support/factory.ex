defmodule Prog.Factory do
  use ExMachina.Ecto, repo: Prog.Repo

  def post_factory do
    title = sequence(:title, &"Post title #{&1}")

    %Prog.Blog.Post{
      title: title,
      description: "Generated by factory",
      slug: Prog.Slug.to_slug(title),
      body: "A post generated by factory",
      body_html: "<div>A post generated by factory</div>",
      published_at: NaiveDateTime.utc_now()
    }
  end
end
