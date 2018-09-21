require 'graphql'

require 'graphql/anonymous_operation_rejector/version'

module GraphQL
  # An GraphQL analyzer to reject anonymous operation (query without operation name).
  #
  # @see http://facebook.github.io/graphql/June2018/#sec-Anonymous-Operation-Definitions
  class AnonymousOperationRejector
    def analyze?(_query)
      true
    end

    # @param query [GraphQL::Query]
    # @return [Hash]
    def initial_value(query)
      { anonymous: anonymous_query?(query) }
    end

    def call(memo, _visit_type, _irep_node)
      memo
    end

    def final_value(memo)
      memo[:anonymous] &&
        GraphQL::AnalysisError.new('Anonymous operation is not allowed. Please add operation name to your query.')
    end

    private

    # @param query [GraphQL::Query]
    # @return [true, false]
    def anonymous_query?(query)
      query.operations.values.any? { |operation| operation.name.nil? }
    end
  end
end
