module SmartManagement
  class IndexBuilder
    attr_accessor :klass, :options

    def initialize(klass, options)
      @klass = klass
      @options = options
    end

    def items
      items = searched_items
      items = Paginer.new(items, options[:pagination]).call
      Sorter.new(items, options[:sort]).call
    end

    def total
      @total ||= searched_items.count
    end

    private

    def searched_items
      @seached_items ||= Searcher.new(klass.all, options[:search]).call
    end
  end
end
