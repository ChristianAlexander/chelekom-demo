defmodule ComponentTest.ParlorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ComponentTest.Parlor` context.
  """

  @doc """
  Generate a pizza.
  """
  def pizza_fixture(attrs \\ %{}) do
    {:ok, pizza} =
      attrs
      |> Enum.into(%{
        cheese_amount: 0.6,
        extra_crispy_crust: true,
        name: "some name",
        sauce_amount: 0.5,
        size: :small,
        special_instructions: "some special_instructions",
        toppings: [:pepperoni, :mushrooms]
      })
      |> ComponentTest.Parlor.create_pizza()

    pizza
  end
end
