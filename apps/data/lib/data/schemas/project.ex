defmodule Data.Project do
  @moduledoc """
  The schema representation of our `projects` table
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Data.Repo

  schema "projects" do
    field(:api_token, :string)
    field(:name, :string)
    field(:tags, {:array, :string})
    field(:url, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :tags, :url])
    |> validate_required([:name, :url])
    |> put_api_token
    |> unique_constraint(:url)
  end

  def generate_api_token do
    32
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> String.replace(~r{[^a-zA-Z0-9]}, "")
    |> binary_part(0, 32)
  end

  defp put_api_token(changeset) do
    token = generate_api_token()

    case Repo.get_by(__MODULE__, %{api_token: token}) do
      nil -> put_change(changeset, :api_token, token)
      _match -> put_api_token(changeset)
    end
  end
end
