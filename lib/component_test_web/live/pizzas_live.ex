defmodule ComponentTestWeb.PizzasLive do
  use ComponentTestWeb, :live_view
  alias ComponentTest.Parlor

  def mount(_params, _session, socket) do
    pizzas = Parlor.list_pizzas()

    socket =
      socket
      |> stream(:pizzas, pizzas)

    if connected?(socket), do: Phoenix.PubSub.subscribe(ComponentTest.PubSub, "pizza-orders")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.table stream>
      <:header>Name</:header>
      <:header>Size</:header>
      <:header>Sauce</:header>
      <:header>Cheese</:header>
      <:header>Toppings</:header>
      <:header>Extra Crispy</:header>
      <:header>Instructions</:header>
      <.tr :for={{dom_id, pizza} <- @streams.pizzas} id={dom_id}>
        <.td><%= pizza.name %></.td>
        <.td><%= Parlor.Pizza.sizes() |> Keyword.get(pizza.size) %></.td>
        <.td><%= round(pizza.sauce_amount * 100) %>%</.td>
        <.td><%= round(pizza.cheese_amount * 100) %>%</.td>
        <.td>
          <.badge :for={topping <- pizza.toppings}><%= topping %></.badge>
        </.td>
        <.td>
          <.badge :if={pizza.extra_crispy_crust} color="success">Yes</.badge>
        </.td>
        <.td>
          <p><%= pizza.special_instructions %></p>
        </.td>
      </.tr>
    </.table>
    """
  end

  def handle_info({:new_order, %ComponentTest.Parlor.Pizza{} = pizza}, socket) do
    socket = stream_insert(socket, :pizzas, pizza, at: 0)

    {:noreply, socket}
  end
end
