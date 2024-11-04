defmodule ComponentTestWeb.Components.MishkaComponents do
  defmacro __using__(_) do
    quote do
      import ComponentTestWeb.Components.FormWrapper, only: [form_wrapper: 1]
      import ComponentTestWeb.Components.RadioField, only: [radio_field: 1]
      import ComponentTestWeb.Components.RangeField, only: [range_field: 1]
      import ComponentTestWeb.Components.TextField, only: [text_field: 1]
      import ComponentTestWeb.Components.ToggleField, only: [toggle_field: 1]

      import ComponentTestWeb.Components.Button,
        only: [button_group: 1, button: 1, input_button: 1, button_link: 1]

      import ComponentTestWeb.Components.Fieldset, only: [fieldset: 1]

      import ComponentTestWeb.Components.CheckboxField,
        only: [checkbox_field: 1, group_checkbox: 1]
    end
  end
end
