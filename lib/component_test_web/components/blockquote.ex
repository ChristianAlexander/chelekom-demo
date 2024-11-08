defmodule ComponentTestWeb.Components.Blockquote do
  @moduledoc """
  This module provides a versatile `ComponentTestWeb.Components.Blockquote` component for creating
  stylish and customizable blockquotes in your Phoenix LiveView application.

  ## Features

  - **Customizable Styles**: Choose from multiple `variant` styles like `default`,
  `outline`, `transparent`, `shadow`, and `unbordered` to match your design needs.
  - **Color Themes**: Apply different color themes, including `primary`, `secondary`,
  `success`, `warning`, and more.
  - **Flexible Sizing**: Control the overall size of the blockquote, as well as specific
  attributes like padding, border radius, and font weight.
  - **Icon and Caption Support**: Add icons and captions to your blockquotes for
  enhanced visual appeal and content clarity.
  - **Positioning Options**: Fine-tune the positioning and spacing of content within the
  blockquote for a polished layout.
  - **Global Attributes**: Utilize global attributes such as `left_border`, `right_border`,
  `hide_border`, and `full_border` to easily customize the border display and positioning.

  Use this module to create visually appealing and content-rich blockquotes that enhance
  the readability and aesthetics of your LiveView applications.
  """

  use Phoenix.Component

  @sizes ["extra_small", "small", "medium", "large", "extra_large"]
  @colors [
    "white",
    "primary",
    "secondary",
    "dark",
    "success",
    "warning",
    "danger",
    "info",
    "light",
    "misc",
    "dawn"
  ]

  @variants [
    "default",
    "outline",
    "transparent",
    "shadow",
    "unbordered"
  ]

  @doc """
  The `blockquote` component is used to display stylized quotations with customizable attributes
  such as `variant`, `color`, and `padding`. It supports optional captions and icons to
  enhance the visual presentation.

  ## Examples

  ```elixir
  <.blockquote left_border hide_icon>
    <p>
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Rem nihil commodi,
      facere voluptatum dolores tempora vero soluta harum nam esse
    </p>
    <:caption
      image="https://example.com/profile.jpg"
      position="left"
    >
      Shahryar Tavakkoli | CEO
    </:caption>
  </.blockquote>

  <.blockquote left_border icon="hero-chat-bubble-left-ellipsis">
    <p>
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Rem nihil commodi,
      facere voluptatum dolores tempora vero soluta harum nam esse
    </p>
    <:caption
      image="https://example.com/profile.jpg"
      position="left"
    >
      Shahryar Tavakkoli | CEO
    </:caption>
  </.blockquote>

  <.blockquote variant="transparent" color="primary">
    <p>
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Rem nihil commodi,
      facere voluptatum dolores tempora vero soluta harum nam esse
    </p>
    <:caption image="https://example.com/profile.jpg">
      Shahryar Tavakkoli | CEO
    </:caption>
  </.blockquote>

  <.blockquote variant="shadow" color="dark">
    <p>
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Rem nihil commodi,
      facere voluptatum dolores tempora vero soluta harum nam esse
    </p>
    <:caption image="https://example.com/profile.jpg">
      Shahryar Tavakkoli | CEO
    </:caption>
  </.blockquote>
  ```
  """
  @doc type: :component
  attr :id, :string,
    default: nil,
    doc: "A unique identifier is used to manage state and interaction"

  attr :variant, :string, values: @variants, default: "default", doc: "Determines the style"
  attr :color, :string, values: @colors, default: "white", doc: "Determines color theme"

  attr :border, :string,
    values: @sizes ++ [nil],
    default: "medium",
    doc: "Determines border style"

  attr :rounded, :string,
    values: @sizes ++ ["full", "none"],
    default: "small",
    doc: "Determines the border radius"

  attr :size, :string,
    default: "medium",
    doc:
      "Determines the overall size of the elements, including padding, font size, and other items"

  attr :space, :string, values: @sizes, default: "small", doc: "Space between items"

  attr :font_weight, :string,
    default: "font-normal",
    doc: "Determines custom class for the font weight"

  attr :padding, :string,
    values: @sizes ++ ["none"],
    default: "small",
    doc: "Determines padding for items"

  attr :class, :string, default: nil, doc: "Custom CSS class for additional styling"
  attr :icon, :string, default: "hero-quote", doc: "Icon displayed alongside of an item"
  attr :icon_class, :string, default: nil, doc: "Determines custom class for the icon"

  slot :caption, required: false do
    attr :image, :string, doc: "Image displayed alongside of an item"
    attr :image_class, :string, doc: "Determines custom class for the image"

    attr :position, :string,
      values: ["right", "left", "center"],
      doc: "Determines the element position"
  end

  slot :inner_block, required: false, doc: "Inner block that renders HEEx content"

  attr :rest, :global,
    include: ~w(left_border right_border hide_border full_border hide_icon),
    doc:
      "Global attributes can define defaults which are merged with attributes provided by the caller"

  def blockquote(assigns) do
    ~H"""
    <figure class={[
      space_class(@space),
      border_class(@border, border_position(@rest)),
      color_variant(@variant, @color),
      rounded_size(@rounded),
      padding_size(@padding),
      size_class(@size),
      @font_weight,
      @class
    ]}>
      <.blockquote_icon
        :if={is_nil(@rest[:hide_icon])}
        name={@icon}
        class={["quote-icon", @icon_class]}
      />
      <blockquote class="p-2 italic">
        <%= render_slot(@inner_block) %>
      </blockquote>
      <figcaption
        :for={caption <- @caption}
        class={[
          "flex items-center space-x-3 rtl:space-x-reverse",
          caption_position(caption[:position])
        ]}
      >
        <img
          :if={!is_nil(caption[:image])}
          class={["w-6 h-6 rounded-full", caption[:image_class]]}
          src={caption[:image]}
        />
        <div class="flex items-center divide-x-2 rtl:divide-x-reverse">
          <%= render_slot(caption) %>
        </div>
      </figcaption>
    </figure>
    """
  end

  @doc type: :component
  attr :name, :string, required: true, doc: "Specifies the name of the element"
  attr :class, :list, default: nil, doc: "Custom CSS class for additional styling"

  defp blockquote_icon(%{name: "hero-quote"} = assigns) do
    ~H"""
    <svg
      class={["w-8 h-8", @class]}
      xmlns="http://www.w3.org/2000/svg"
      fill="currentColor"
      viewBox="0 0 18 14"
    >
      <path d="M6 0H2a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4v1a3 3 0 0 1-3 3H2a1 1 0 0 0 0 2h1a5.006 5.006 0 0 0 5-5V2a2 2 0 0 0-2-2Zm10 0h-4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4v1a3 3 0 0 1-3 3h-1a1 1 0 0 0 0 2h1a5.006 5.006 0 0 0 5-5V2a2 2 0 0 0-2-2Z" />
    </svg>
    """
  end

  defp blockquote_icon(assigns) do
    ~H"""
    <.icon
      :if={!is_nil(@name)}
      name={@name}
      class={Enum.reject(@class, &is_nil(&1)) |> Enum.join(" ")}
    />
    """
  end

  defp caption_position("right") do
    "ltr:justify-end rtl:justify-start"
  end

  defp caption_position("left") do
    "ltr:justify-start rtl:justify-end"
  end

  defp caption_position("center") do
    "justify-center"
  end

  defp caption_position(_), do: caption_position("right")

  defp space_class("extra_small"), do: "space-y-2"

  defp space_class("small"), do: "space-y-3"

  defp space_class("medium"), do: "space-y-4"

  defp space_class("large"), do: "space-y-5"

  defp space_class("extra_large"), do: "space-y-6"

  defp space_class(params) when is_binary(params), do: params

  defp border_class(_, "none") do
    ["border-0"]
  end

  defp border_class("extra_small", position) do
    [
      position == "left" && "border-s",
      position == "right" && "border-e",
      position == "full" && "border"
    ]
  end

  defp border_class("small", position) do
    [
      position == "left" && "border-s-2",
      position == "right" && "border-s-2",
      position == "full" && "border-2"
    ]
  end

  defp border_class("medium", position) do
    [
      position == "left" && "border-s-[3px]",
      position == "right" && "border-e-[3px]",
      position == "full" && "border-[3px]"
    ]
  end

  defp border_class("large", position) do
    [
      position == "left" && "border-s-4",
      position == "right" && "border-e-4",
      position == "full" && "border-4"
    ]
  end

  defp border_class("extra_large", position) do
    [
      position == "left" && "border-s-[5px]",
      position == "right" && "border-e-[5px]",
      position == "full" && "border-[5px]"
    ]
  end

  defp border_class(params, _) when is_binary(params), do: [params]
  defp border_class(nil, _), do: nil

  defp rounded_size("extra_small"), do: "rounded-sm"

  defp rounded_size("small"), do: "rounded"

  defp rounded_size("medium"), do: "rounded-md"

  defp rounded_size("large"), do: "rounded-lg"

  defp rounded_size("extra_large"), do: "rounded-xl"

  defp rounded_size("full"), do: "rounded-full"

  defp rounded_size(nil), do: "rounded-none"

  defp padding_size("extra_small"), do: "p-1"

  defp padding_size("small"), do: "p-2"

  defp padding_size("medium"), do: "p-3"

  defp padding_size("large"), do: "p-4"

  defp padding_size("extra_large"), do: "p-5"

  defp padding_size("none"), do: "p-0"

  defp padding_size(params) when is_binary(params), do: params

  defp padding_size(_), do: padding_size("small")

  defp size_class("extra_small"), do: "text-xs [&>.quote-icon]:size-7"

  defp size_class("small"), do: "text-sm [&>.quote-icon]:size-8"

  defp size_class("medium"), do: "text-base [&>.quote-icon]:size-9"

  defp size_class("large"), do: "text-lg [&>.quote-icon]:size-10"

  defp size_class("extra_large"), do: "text-xl [&>.quote-icon]:size-12"

  defp size_class(params) when is_binary(params), do: params

  defp size_class(_), do: size_class("medium")

  defp color_variant("default", "primary") do
    "bg-[#4363EC] text-white border-[#2441de]"
  end

  defp color_variant("default", "info") do
    "bg-[#E5F0FF] text-[#004FC4] border-[#004FC4]"
  end

  defp border_position(%{hide_border: true}), do: "none"
  defp border_position(%{left_border: true}), do: "left"
  defp border_position(%{right_border: true}), do: "right"
  defp border_position(%{full_border: true}), do: "full"
  defp border_position(_), do: "left"

  attr :name, :string, required: true, doc: "Specifies the name of the element"
  attr :class, :any, default: nil, doc: "Custom CSS class for additional styling"

  defp icon(%{name: "hero-" <> _, class: class} = assigns) when is_list(class) do
    ~H"""
    <span class={[@name] ++ @class} />
    """
  end

  defp icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end
end
