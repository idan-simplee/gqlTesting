class Types::MutationType < GraphQL::Schema::Object
  graphql_name 'Mutation_type'

  field :createLink, function: Resolvers::CreateLink.new
  field :createVote, function: Resolvers::CreateVote.new
  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new

end