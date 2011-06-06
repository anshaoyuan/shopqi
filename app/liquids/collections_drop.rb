class CollectionsDrop < Liquid::Drop

  def initialize(shop)
    @shop = shop
  end

  def before_method(handle) #相当于method_missing
    CollectionDrop.new @shop.custom_collections.where(handle: handle).first
  end

end

class CollectionDrop < Liquid::Drop

  def initialize(collection)
    @collection = collection
  end

  def products
    @collection.products.map do |product|
      ProductDrop.new product
    end
  end

end