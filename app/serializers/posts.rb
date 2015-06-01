class PostsSerializer < ActiveModel::Serializer
  attributes :id, :author, :subject, :sent_date, :body
end