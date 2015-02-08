module SmartManagement
  class IndexBuilder
    attr_accessor :klass, :options

    def initialize(klass, options)
      @klass = klass
      @options = options
    end

    def call
      items = klass.all
      items = Searcher.new(items, options[:search]).call
      total = items.count

      items = Paginer.new(items, options[:pagination]).call
      items = Sorter.new(items, options[:sort]).call

      { items: items, meta: { total: total} }
    end
  end
end
