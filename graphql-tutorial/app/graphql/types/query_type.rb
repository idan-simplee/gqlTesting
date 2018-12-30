module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query_type'

    field :allUsers, [Types::UserType],null: false
    def all_users
      User.all
    end

    field :user, Types::UserType,null: true do
      argument :user_id, Integer, required: true,as: :id
    end
    def user(id:)
      User.find(id)
    end

    # field :allLinks, resolver: Resolvers::LinksSearch
    field :link, Types::LinkType, null: true do
      argument :link_id, ID, required: true,as: :id
    end
    def link(id:)
      Link.find_by(id)
    end

    field :all_links, [Types::LinkType], null: true
    def all_links
      Link.all
    end

    field :link_by_book_title, [Types::LinkType], null: true do
      argument :book_title, String, required: true,as: :book_title
    end
    def link_by_book_title(book_title:)
      Link.all.select{|x| x.book_title ==  book_title}
    end

    field :all_votes, [Types::VoteType], null: true
    def all_votes
      Vote.all
    end


  end
end
