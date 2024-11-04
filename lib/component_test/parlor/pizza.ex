defmodule ComponentTest.Parlor.Pizza do
  use Ecto.Schema
  import Ecto.Changeset

  @pizza_toppings [
    pepperoni: "Pepperoni",
    mushrooms: "Mushrooms",
    bell_peppers: "Bell Peppers",
    onions: "Onions",
    olives: "Olives",
    sausage: "Sausage",
    bacon: "Bacon",
    pineapple: "Pineapple"
  ]

  schema "pizzas" do
    field :name, :string
    field :size, Ecto.Enum, values: [:small, :medium, :large], default: :medium
    field :sauce_amount, :float, default: 0.5
    field :cheese_amount, :float, default: 0.5
    field :toppings, {:array, Ecto.Enum}, values: Keyword.keys(@pizza_toppings), default: []
    field :extra_crispy_crust, :boolean, default: false
    field :special_instructions, :string, default: ""

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pizza, attrs) do
    pizza
    |> cast(attrs, [
      :name,
      :size,
      :sauce_amount,
      :cheese_amount,
      :toppings,
      :extra_crispy_crust,
      :special_instructions
    ])
    |> validate_required([
      :name,
      :size,
      :sauce_amount,
      :cheese_amount
    ])
    |> validate_number(:sauce_amount, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0)
    |> validate_number(:cheese_amount, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0)
  end

  def sizes() do
    [small: "Small", medium: "Medium", large: "Large"]
  end

  def toppings() do
    @pizza_toppings
  end
end
