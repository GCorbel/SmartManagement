module SmartManagement
  module Helpers
    COLUMNS_AT_FIRST = ['id']
    COLUMNS_AT_END = ['created_at', 'updated_at']
    PROTECTED_COLUMNS = ['id', 'created_at', 'updated_at']
    UNSEARCHABLE_TYPES = [:string, :text]

    def smart_management_row(column)
      if column.sql_type == 'datetime'
        filter = " | date: 'dd-MM-yyyy hh:mm:ss'"
      end
      "{{row.resource.#{column.name} #{filter} }}"
    end

    def visible_schema
      {
        singular_model_name.to_sym => {
          only: visible_columns_names.map(&:to_sym)
        }
      }
    end

    def visible_columns
      model_class.columns
    end

    def visible_columns_names
      COLUMNS_AT_FIRST + (visible_columns.map(&:name) - PROTECTED_COLUMNS) +
        COLUMNS_AT_END
    end

    def editable_columns
      model_class.columns.reject do |column|
        PROTECTED_COLUMNS.include?(column.name)
      end
    end

    def editable_columns_names
      editable_columns.map(&:name)
    end

    def singular_model_name
      controller_name.to_s.singularize
    end

    def plural_model_name
      controller_name.to_s
    end

    def model_class
      singular_model_name.capitalize.camelize.constantize
    end

    def colspan
      model_class.columns.length + 2
    end

    def field_for(form:, klass:, column:)
      if klass.reflect_on_association(assoc_name(column.name))
        form.send(:association, assoc_name(column.name),
                  ng: { model: "editedResource.#{column.name}" } )
      else
        form.send(:input, column.name, ng: { model: "editedResource.#{column.name}" } )
      end
    end

    def searchable?(column)
      UNSEARCHABLE_TYPES.include?(column.type)
    end

    private

    def assoc_name(column)
      column.gsub(/_id$/, '')
    end
  end
end

ActionView::Base.send(:include, SmartManagement::Helpers) if defined?(ActionView::Base)
