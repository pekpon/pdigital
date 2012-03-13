class AddSeoFieldsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :subtitle, :string

    add_column :articles, :title_url, :string

  end
end
