class AddImageable < ActiveRecord::Migration[5.2]
  def change
      add_column :articles, :imageable_id, :integer
      add_column :articles, :imageable_type, :string

      Article.all.each do |article|
          article.imageable_type = 'User'
          article.imageable_id = article.user_id
          article.save
      end
  end
end
