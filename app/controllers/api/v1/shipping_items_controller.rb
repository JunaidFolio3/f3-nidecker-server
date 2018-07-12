class Api::V1::ShippingItemsController < ApplicationController

  def executeDBOperationForShippingItem
    shippingItemsData = params[:_json]
    # puts "request body: #{shippingItemsData}"

    i = 0
    # puts "request body: #{shippingItemsData}"
    while i < shippingItemsData.length  do

      case shippingItemsData[i][:operation_id]
      when '1'
        puts "=====createShippingItem====="
        createShippingItem(shippingItemsData[i])
      
      when '2'
        puts "=====updateShippingItem====="
        updateShippingItem(shippingItemsData[i])

      when '3'
        puts "=====deleteShippingItem====="
        deleteShippingItem(shippingItemsData[i])
      end
      i +=1
    end

    render json: {status: 'SUCCESS', message:'Saved Shipping Item', data:shippingItemsData},status: :ok
  end

  def createShippingItem(shippingItem)
    puts "createShippingItem:shippingItem: #{shippingItem}"
  
  end

  def updateShippingItem(shippingItem)
    puts "updateShippingItem:shippingItem: #{shippingItem}"
  
  end

  def deleteShippingItem(shippingItem)
    puts "deleteShippingItem:shippingItem: #{shippingItem}"
  
  end

end
