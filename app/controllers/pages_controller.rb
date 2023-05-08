class PagesController < ApplicationController
  def home
    # Post: title, content, created_at, record_type
    # Comment: nil, content, created_at, record_type
    #   @records = ActiveRecord::Base.connection.exec_query("
    #   SELECT title, content, created_at, 'Post' as record_type
    #   FROM posts
    #   UNION
    #   SELECT NULL as title, comments.content, comments.created_at, 'Comment' as record_type
    #   FROM comments
    #   INNER JOIN posts ON posts.id = comments.post_id
    #   ORDER BY created_at ASC, content ASC;
    # ").map { |row| PostsAndComments.new(row) }

    @records = Post.find_by_sql("
    SELECT title, content, created_at, 'Post' as record_type
    FROM posts
    UNION
    SELECT NULL as title, comments.content, comments.created_at, 'Comment' as record_type
    FROM comments
    INNER JOIN posts ON posts.id = comments.post_id
    ORDER BY created_at ASC, content ASC;
  ")

  end
end
