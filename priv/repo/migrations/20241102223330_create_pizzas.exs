defmodule ComponentTest.Repo.Migrations.CreatePizzas do
  use Ecto.Migration

  def change do
    create table(:pizzas) do
      add :name, :string
      add :size, :string
      add :sauce_amount, :float
      add :cheese_amount, :float
      add :toppings, {:array, :string}
      add :extra_crispy_crust, :boolean, default: false, null: false
      add :special_instructions, :text

      timestamps(type: :utc_datetime)
    end
  end
end
