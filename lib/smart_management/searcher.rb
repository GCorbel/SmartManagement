module SmartManagement
  class Searcher
    def initialize(data, options)
      @data = data
      @options = options
    end

    def call
      if @options.present?
        @options.each do |k, v|
          @data = @data.where("#{@data.table_name}.#{k} like ?", "%#{v}%")
        end
      end
      @data
    end
  end
end
