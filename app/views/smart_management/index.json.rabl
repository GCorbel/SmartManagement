schema = visible_schema[singular_model_name.to_sym]

child(index_builder.items) do |items|
  attributes *schema[:only]
  if schema[:include].present?
    items.each do |item|
      schema[:include].each do |k, v|
        child(item.send(k)) do
          attributes *v[:only]
        end
      end
    end
  end
end


node(:meta) { { total: index_builder.items.length,
                pluralModelName: plural_model_name } }
