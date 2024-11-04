defmodule ComponentTest.ParlorTest do
  use ComponentTest.DataCase

  alias ComponentTest.Parlor

  describe "pizzas" do
    alias ComponentTest.Parlor.Pizza

    import ComponentTest.ParlorFixtures

    @invalid_attrs %{
      name: nil,
      size: nil,
      sauce_amount: nil,
      cheese_amount: nil,
      toppings: nil,
      extra_crispy_crust: nil,
      special_instructions: nil
    }

    test "list_pizzas/0 returns all pizzas" do
      pizza = pizza_fixture()
      assert Parlor.list_pizzas() == [pizza]
    end

    test "get_pizza!/1 returns the pizza with given id" do
      pizza = pizza_fixture()
      assert Parlor.get_pizza!(pizza.id) == pizza
    end

    test "create_pizza/1 with valid data creates a pizza" do
      valid_attrs = %{
        name: "some name",
        size: :small,
        sauce_amount: 0.2,
        cheese_amount: 0.1,
        toppings: ["bacon", "olives"],
        extra_crispy_crust: true,
        special_instructions: "some special_instructions"
      }

      assert {:ok, %Pizza{} = pizza} = Parlor.create_pizza(valid_attrs)
      assert pizza.name == "some name"
      assert pizza.size == :small
      assert pizza.sauce_amount == 0.2
      assert pizza.cheese_amount == 0.1
      assert pizza.toppings == [:bacon, :olives]
      assert pizza.extra_crispy_crust == true
      assert pizza.special_instructions == "some special_instructions"
    end

    test "create_pizza/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parlor.create_pizza(@invalid_attrs)
    end

    test "update_pizza/2 with valid data updates the pizza" do
      pizza = pizza_fixture()

      update_attrs = %{
        name: "some updated name",
        size: :medium,
        sauce_amount: 0.9,
        cheese_amount: 1.0,
        toppings: [:pepperoni],
        extra_crispy_crust: false,
        special_instructions: "some updated special_instructions"
      }

      assert {:ok, %Pizza{} = pizza} = Parlor.update_pizza(pizza, update_attrs)
      assert pizza.name == "some updated name"
      assert pizza.size == :medium
      assert pizza.sauce_amount == 0.9
      assert pizza.cheese_amount == 1.0
      assert pizza.toppings == [:pepperoni]
      assert pizza.extra_crispy_crust == false
      assert pizza.special_instructions == "some updated special_instructions"
    end

    test "update_pizza/2 with invalid data returns error changeset" do
      pizza = pizza_fixture()
      assert {:error, %Ecto.Changeset{}} = Parlor.update_pizza(pizza, @invalid_attrs)
      assert pizza == Parlor.get_pizza!(pizza.id)
    end

    test "delete_pizza/1 deletes the pizza" do
      pizza = pizza_fixture()
      assert {:ok, %Pizza{}} = Parlor.delete_pizza(pizza)
      assert_raise Ecto.NoResultsError, fn -> Parlor.get_pizza!(pizza.id) end
    end

    test "change_pizza/1 returns a pizza changeset" do
      pizza = pizza_fixture()
      assert %Ecto.Changeset{} = Parlor.change_pizza(pizza)
    end
  end
end
