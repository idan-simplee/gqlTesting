# defines a new GraphQL type
class Types::LinkType < GraphQL::Schema::Object
  # this type is named `Link`
  graphql_name 'Link'

  # it has the following fields
  field :id, Integer, null: false
  field :url, String, null: false
  field :description, String, null: true
  field :book_title, String, null:false
  field :posted_by, Types::UserType, method: :user, null: false
  field :votes, [Types::VoteType], null: true
end