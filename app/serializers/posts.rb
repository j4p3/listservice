class PostsSerializer < ActiveModel::PostsSerializer
  attributes :id, :author, :subject, :sent_date, :body
end