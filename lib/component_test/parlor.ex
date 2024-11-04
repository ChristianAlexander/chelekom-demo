defmodule ComponentTest.Parlor do
  @moduledoc """
  The Parlor context.
  """

  import Ecto.Query, warn: false
  alias ComponentTest.Repo

  alias ComponentTest.Parlor.Pizza

  @doc """
  Returns the list of pizzas.

  ## Examples

      iex> list_pizzas()
      [%Pizza{}, ...]

  """
  def list_pizzas do
    Repo.all(Pizza)
  end

  @doc """
  Gets a single pizza.

  Raises `Ecto.NoResultsError` if the Pizza does not exist.

  ## Examples

      iex> get_pizza!(123)
      %Pizza{}

      iex> get_pizza!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pizza!(id), do: Repo.get!(Pizza, id)

  @doc """
  Creates a pizza.

  ## Examples

      iex> create_pizza(%{field: value})
      {:ok, %Pizza{}}

      iex> create_pizza(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pizza(attrs \\ %{}) do
    with {:ok, pizza} <-
           %Pizza{}
           |> Pizza.changeset(attrs)
           |> Repo.insert() do
      Phoenix.PubSub.broadcast(ComponentTest.PubSub, "pizza-orders", {:new_order, pizza})

      {:ok, pizza}
    end
  end

  @doc """
  Updates a pizza.

  ## Examples

      iex> update_pizza(pizza, %{field: new_value})
      {:ok, %Pizza{}}

      iex> update_pizza(pizza, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pizza(%Pizza{} = pizza, attrs) do
    pizza
    |> Pizza.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pizza.

  ## Examples

      iex> delete_pizza(pizza)
      {:ok, %Pizza{}}

      iex> delete_pizza(pizza)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pizza(%Pizza{} = pizza) do
    Repo.delete(pizza)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pizza changes.

  ## Examples

      iex> change_pizza(pizza)
      %Ecto.Changeset{data: %Pizza{}}

  """
  def change_pizza(%Pizza{} = pizza, attrs \\ %{}) do
    Pizza.changeset(pizza, attrs)
  end
end
