class Types::AuthProviderEmailInput < GraphQL::Schema::InputObject
  graphql_name 'AUTH_PROVIDER_EMAIL'

  argument :email, String, required: true
  argument :password, String, required: true
end