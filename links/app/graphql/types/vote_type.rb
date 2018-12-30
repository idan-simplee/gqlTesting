class Types::VoteType < GraphQL::Schema::Object
  # this type is named `Link`
  graphql_name 'Vote'

  field :id, Integer, null: false
  field :user, Types::UserType, null: false
  field :link, Types::LinkType, null: false
end