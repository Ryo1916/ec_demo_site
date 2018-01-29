json.extract! product, :id, :name, :price, :description, :category_id, :img_name, :created_at, :updated_at
json.url product_url(product, format: :json)
