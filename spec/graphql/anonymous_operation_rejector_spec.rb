require 'graphql'

RSpec.describe GraphQL::AnonymousOperationRejector do
  it 'has a version number' do
    expect(GraphQL::AnonymousOperationRejector::VERSION).not_to be nil
  end

  let(:schema) do
    query_type = Class.new(GraphQL::Schema::Object) do
      graphql_name 'Query'
      field :hello, String, null: false

      def hello
        'world'
      end
    end

    Class.new(GraphQL::Schema) do
      query_analyzer GraphQL::AnonymousOperationRejector.new
      query query_type
    end
  end

  it 'allows GraphQL query with operation name' do
    result = schema.execute('query operationName { hello }')
    expect(result.to_h['data']).to eq('hello' => 'world')
  end

  it 'rejects GraphQL query without operation name' do
    result = schema.execute('{ hello }')
    message = 'Anonymous operation is not allowed. Please add operation name to your query.'
    expect(result.to_h['errors']).to include(a_hash_including('message' => message))
  end
end
