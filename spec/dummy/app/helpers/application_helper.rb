module ApplicationHelper

  def visible_schema
    { user: { include: { company: { only: [:name] } }, only: [:id, :name] } }
  end

  def visible_columns
    model_class.columns.select do |column|
      visible_schema[:user][:only].include? column.name.to_sym
    end
  end

end
