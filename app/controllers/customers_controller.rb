#encoding: utf-8
class CustomersController < ApplicationController
  prepend_before_filter :authenticate_user!
  layout 'admin'

  expose(:shop) { current_user.shop }
  expose(:customers) do
    page_size = 25
    if params[:q]
      shop.customers.limit(page_size).metasearch(name_contains: params[:q]).all
    else
      shop.customers.limit(page_size).all
    end
  end
  expose(:customer)
  expose(:customers_json) do
    customers.to_json({
      include: :orders,
      except: [ :created_at, :updated_at ]
    })
  end
  expose(:customer_json) do
    customer.to_json({
      include: {
        addresses: {}
      },
      except: [ :created_at, :updated_at ]
    })
  end
  expose(:page_sizes) { KeyValues::PageSize.hash }

  def search
    render json: customers_json
  end
end