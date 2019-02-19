defmodule Prog.SlugTest do
  use ExUnit.Case, async: true

  test "converts to lowercase" do
    assert Prog.Slug.to_slug("Olá mundo") == "olá-mundo"
    assert Prog.Slug.to_slug("OLÁ MUNDO") == "olá-mundo"
  end

  test "removes punctuations" do
    assert Prog.Slug.to_slug("Olá, mundo")  == "olá-mundo"
    assert Prog.Slug.to_slug("tudo certo?") == "tudo-certo"
    assert Prog.Slug.to_slug("um/dois")     == "um-dois"
    assert Prog.Slug.to_slug("um'dois")     == "um-dois"
    assert Prog.Slug.to_slug("um \"dois\"") == "um-dois"
  end
end