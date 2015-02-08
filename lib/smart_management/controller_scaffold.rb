module SmartManagement
  module ControllerScaffold
    def index
      respond_to do |format|
        format.html { render 'index' }
        format.json do
          render json: SmartManagement::IndexBuilder.
            new(User, smart_management_options).call
        end
      end
    end

    def show
      respond_with(user)
    end

    def create
      user.save
      respond_with(user)
    end

    def update
      if user.save
        render json: user, status: :ok
      else
        render json: { errors: resource.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      user.destroy
      respond_with(user)
    end

    private

    def user_params
      params.require(:user).permit(:name, :age, :company_id)
    end

    def sort_options
      JSON.parse(params["sort"]).symbolize_keys if params["sort"]
    end

    def pagination_options
      JSON.parse(params["pagination"]).symbolize_keys if params["pagination"]
    end

    def search_options
      if params["search"]
        search_params = JSON.parse(params["search"])
        if search_params["predicateObject"]
          search_params["predicateObject"].symbolize_keys
        end
      end
    end

    def smart_management_options
      { sort: sort_options, pagination: pagination_options, search: search_options }
    end

    private

    def self.included(controller)
      name = controller.controller_name
      singular = name.singularize
      controller.expose(name)
      controller.expose(singular, attributes: "#{singular}_params")
    end

  end
end
