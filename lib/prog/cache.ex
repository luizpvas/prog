defmodule Prog.Cache do
  def get_or_store(key, callback) do
    ConCache.get_or_store(:prog_cache, key, callback)
  end
end
