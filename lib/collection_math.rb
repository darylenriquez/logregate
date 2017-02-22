class CollectionMath
  class << self
    def mean(collection)
      total = collection.inject(:+) || 0

      total.zero? ? 0 : (total / collection.length)
    end

    def median(collection)
      sorted_collection = collection.sort
      collection_length = collection.length
      middle_index      = collection_length / 2

      if collection_length.odd?
        sorted_collection[middle_index]
      else
        ((sorted_collection[middle_index] || 0) + (sorted_collection[middle_index - 1] || 0)) * 0.5
      end
    end

    def mode(collection)
      frequency = collection.inject({}) { |result, item| result.merge(item => ((result[item] || 0) + 1)) }

      highest_value(frequency).join(',')
    end

    def highest_value(collection)
      collection.map { |item, count| item if count == collection.values.max }.compact
    end
  end
end