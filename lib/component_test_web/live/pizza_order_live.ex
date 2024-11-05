defmodule ComponentTestWeb.PizzaOrderLive do
  use ComponentTestWeb, :live_view
  alias ComponentTest.Parlor
  alias Parlor.Pizza

  def mount(_params, _session, socket) do
    socket = socket |> assign(form: to_form(Parlor.change_pizza(%Pizza{})))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-xl font-bold mb-4">Pizza Chelekom</h1>
    <.form_wrapper for={@form} phx-change="validate" phx-submit="submit" class="space-y-4">
      <.text_field type="text" field={@form[:name]} label="Name" placeholder="My Custom Pizza" />
      <.fieldset id="size-set" space="medium" legend="Size">
        <:control :for={{value, label} <- Pizza.sizes()}>
          <.radio_field
            id={"#{@form[:size].name}_#{value}"}
            name={@form[:size].name}
            checked={
              if @form.params["size"],
                do: @form.params["size"] == Atom.to_string(value),
                else: @form.data.size == value
            }
            value={value}
            label={label}
          />
        </:control>
      </.fieldset>
      <% value =
        round(
          if(is_binary(@form[:sauce_amount].value),
            do: String.to_float(@form[:sauce_amount].value),
            else: @form[:sauce_amount].value
          ) *
            100
        ) %>
      <% label_suffix = if value < 30, do: "Light", else: if(value > 70, do: "Extra", else: "Normal") %>
      <.range_field
        label={"Sauce Amount: #{value}% (#{label_suffix})"}
        field={@form[:sauce_amount]}
        min="0.0"
        max="1.0"
        step="0.01"
      />
      <% value =
        round(
          if(is_binary(@form[:cheese_amount].value),
            do: String.to_float(@form[:cheese_amount].value),
            else: @form[:cheese_amount].value
          ) *
            100
        ) %>
      <% label_suffix = if value < 30, do: "Light", else: if(value > 70, do: "Extra", else: "Normal") %>
      <.range_field
        label={"Cheese Amount: #{value}% (#{label_suffix})"}
        field={@form[:cheese_amount]}
        min="0.0"
        max="1.0"
        step="0.01"
      />
      <.fieldset id="toppings-set" space="medium" legend="Toppings">
        <:control :for={{value, label} <- Pizza.toppings()}>
          <.checkbox_field
            id={"#{@form[:toppings].name}_#{value}"}
            field={@form[:toppings]}
            value={value}
            label={label}
            checked={
              if @form.params["toppings"],
                do: Enum.member?(@form.params["toppings"], Atom.to_string(value)),
                else: Enum.member?(@form.data.toppings, value)
            }
          />
        </:control>
      </.fieldset>
      <.toggle_field
        field={@form[:extra_crispy_crust]}
        label="Extra Crispy Crust"
        checked={
          if @form.params["extra_crispy_crust"],
            do: Phoenix.HTML.Form.normalize_value("checkbox", @form.params["extra_crispy_crust"]),
            else: @form.data.extra_crispy_crust
        }
      />
      <.text_field
        field={@form[:special_instructions]}
        label="Special Instructions"
        placeholder="Any special requests?"
      />
      <.button type="submit" color="primary">Order</.button>
    </.form_wrapper>
    """
  end

  def handle_event("validate", %{"pizza" => params}, socket) do
    form =
      %Pizza{}
      |> Parlor.change_pizza(params)
      |> to_form(action: :validate)

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("submit", %{"pizza" => pizza_params}, socket) do
    case Parlor.create_pizza(pizza_params) do
      {:ok, _pizza} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pizza Ordered!")
         |> redirect(to: ~p"/pizzas")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
