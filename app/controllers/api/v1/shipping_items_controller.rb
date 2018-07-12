class Api::V1::ShippingItemsController < ApplicationController

  def executeDBOperationForShippingItem
    shippingItemsData = params[:_json]
    shippingItemResponses = Array.new()

    i = 0
    while i < shippingItemsData.length  do

      case shippingItemsData[i][:operation_id]
      when '1'
        puts "=====+++++++++++++createShippingItem=====+++++++++++++"
        responseOfCreatedShippingItem = createShippingItem(shippingItemsData[i])
        shippingItemResponses.push(responseOfCreatedShippingItem)
      when '2'
        puts "=====+++++++++++++updateShippingItem=====+++++++++++++"
        responseOfUpdatedShippingItem = updateShippingItem(shippingItemsData[i])
        shippingItemResponses.push(responseOfUpdatedShippingItem)
      when '3'
        puts "=====+++++++++++++deleteShippingItem=====+++++++++++++"
        responseOfDeletedShippingItem = deleteShippingItem(shippingItemsData[i])
        shippingItemResponses.push(responseOfDeletedShippingItem)
      end
      i +=1
    end

    render json: {data:shippingItemResponses},status: :ok
  end

  def createShippingItem(shippingItemObj)
    # puts "createShippingItem:shippingItemObj: #{shippingItemObj}"
    shippingitem = ShippingItem.new( 
      :name => shippingItemObj[:name],
      :rate => shippingItemObj[:rate]
      )
     
    if shippingitem.save
      resultShippingItem = appendDataInResultShippingItem(shippingItemObj, shippingitem)
      return  {status: 'SUCCESS', message:'Shipping Item created', data:resultShippingItem}
    else
      # return  {status: 'ERROR', message:'Shipping Item not created', data:shippingitem.errors},status: :unprocessable_entity
      return  {status: 'ERROR', message:'Shipping Item not created', data:[]}
    end
  end

  def updateShippingItem(shippingItemObj)
    # puts "updateShippingItem:shippingItemObj: #{shippingItemObj}"
    shippingitem = ShippingItem.find_by_id(shippingItemObj[:externalid])
    puts "=====+++++++++++++=====+++++++++++++=====+++++++++++++= #{!shippingitem.nil?}"
    if !shippingitem.nil? && shippingitem.update_attributes(
        :name => shippingItemObj[:name],
        :rate => shippingItemObj[:rate]
      )
      resultShippingItem = appendDataInResultShippingItem(shippingItemObj, shippingitem)
      return {status: 'SUCCESS', message:'Shipping Item Updated', data:resultShippingItem}
    else
      # return {status: 'ERROR', message:'Shipping Item not updated', data:'shippingitem.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'Shipping Item not exist', data:[]}
    end
  end

  def deleteShippingItem(shippingItemObj)
    # puts "deleteShippingItem:shippingItemObj: #{shippingItemObj}"
    shippingitem = ShippingItem.find_by_id(shippingItemObj[:externalid])
    if !shippingitem.nil?
      shippingitem.destroy
      resultShippingItem = appendDataInResultShippingItem(shippingItemObj, shippingitem)
      return {status: 'SUCCESS', message:'Shipping Item Deleted', data:resultShippingItem}
    else
      # return {status: 'ERROR', message:'Shipping Item not Deleted', data:'shippingitem.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'Shipping Item not exist', data:[]}
    end
  end

  def appendDataInResultShippingItem(shippingItemObj, shippingitem)
    resultShippingItem = shippingitem.as_json
    resultShippingItem[:nsid] = shippingItemObj[:nsid]
    resultShippingItem[:status_id] = '2'
    resultShippingItem[:operation_id] = shippingItemObj[:operation_id]
    resultShippingItem[:recordtype_id] = shippingItemObj[:recordtype_id]
    return resultShippingItem
  end

end
