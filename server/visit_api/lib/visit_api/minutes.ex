defmodule VisitApi.Minutes do
  @moduledoc """
  The Minutes context.
  """

  import Ecto.Query, warn: false
  alias VisitApi.Repo

  alias VisitApi.Minutes.Minute

  @doc """
  Returns the list of minutes.

  ## Examples

      iex> list_minutes()
      [%Minute{}, ...]

  """
  def list_minutes do
    Repo.all(Minute)
  end

  @doc """
  Gets a single minute.

  Raises `Ecto.NoResultsError` if the Minute does not exist.

  ## Examples

      iex> get_minute!(123)
      %Minute{}

      iex> get_minute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_minute!(id), do: Repo.get!(Minute, id)

  @doc """
  Creates a minute.

  ## Examples

      iex> create_minute(%{field: value})
      {:ok, %Minute{}}

      iex> create_minute(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_minute(attrs \\ %{}) do
    %Minute{}
    |> Minute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a minute.

  ## Examples

      iex> update_minute(minute, %{field: new_value})
      {:ok, %Minute{}}

      iex> update_minute(minute, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_minute(%Minute{} = minute, attrs) do
    minute
    |> Minute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a minute.

  ## Examples

      iex> delete_minute(minute)
      {:ok, %Minute{}}

      iex> delete_minute(minute)
      {:error, %Ecto.Changeset{}}

  """
  def delete_minute(%Minute{} = minute) do
    Repo.delete(minute)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking minute changes.

  ## Examples

      iex> change_minute(minute)
      %Ecto.Changeset{data: %Minute{}}

  """
  def change_minute(%Minute{} = minute, attrs \\ %{}) do
    Minute.changeset(minute, attrs)
  end
end
