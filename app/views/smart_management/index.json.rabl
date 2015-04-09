child(index_builder.items) do
  attributes *visible_schema[singular_model_name.to_sym][:only]
end

node(:meta) { { total: 10, pluralModelName: plural_model_name } }
