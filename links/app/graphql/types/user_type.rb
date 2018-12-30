class Types::UserType < GraphQL::Schema::Object
  # this type is named `Link`
  graphql_name 'User'

  # it has the following fields
  field :id, Integer, null: false
  field :name, String, null: false
  field :email, String, null: false
end