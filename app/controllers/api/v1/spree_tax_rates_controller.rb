require 'date'

class Api::V1::SpreeTaxRatesController < ApplicationController

  def parseDate
    myDate = "date: #{Date.parse('2018-07-13T08:09:54.135Z').strftime('%m/%d/%Y')}"
    puts myDate
    render json: {data:myDate}
  end

  def executeDBOperationForTaxCode
    taxCodesData = params[:_json]
    taxCodeResponses = Array.new()

    i = 0
    while i < taxCodesData.length  do

      case taxCodesData[i][:operation_id]
      when '1'
        puts "=====+++++++++++++createTaxCode=====+++++++++++++"
        responseOfCreatedTaxCode = createTaxCode(taxCodesData[i])
        taxCodeResponses.push(responseOfCreatedTaxCode)
      when '2'
        puts "=====+++++++++++++updateTaxCode=====+++++++++++++"
        responseOfUpdatedTaxCode = updateTaxCode(taxCodesData[i])
        taxCodeResponses.push(responseOfUpdatedTaxCode)
      when '3'
        puts "=====+++++++++++++deleteTaxCode=====+++++++++++++"
        responseOfDeletedTaxCode = deleteTaxCode(taxCodesData[i])
        taxCodeResponses.push(responseOfDeletedTaxCode)
      end
      i +=1
    end
    
    render json: {data:taxCodeResponses},status: :ok
  end

  def createTaxCode(taxCodeObj)
    # puts "createTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = SpreeTaxRate.new( 
      :name => taxCodeObj[:name],
      :rate => taxCodeObj[:rate],
      :tax_category_id => taxCodeObj[:tax_category_id],
      :included_in_price => taxCodeObj[:included_in_price],
      :show_rate_in_label => taxCodeObj[:show_rate_in_label],
      :zone_id => taxCodeObj[:zone_id],
      :store_id => taxCodeObj[:store_id]
      )
     
    if taxcode.save
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return  {status: 'SUCCESS', message:'Taxcode created', data: resultTaxCode}
    else
      failedResultTaxCode = appendDataWhenTaxCodeFailed(taxCodeObj)
      # return  {status: 'ERROR', message:'Taxcode not created', data:taxcode.errors},status: :unprocessable_entity
      return  {status: 'ERROR', message:'Taxcode not created', data: failedResultTaxCode }
    end
  end

  def updateTaxCode(taxCodeObj)
    # puts "updateTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = SpreeTaxRate.find_by_id(taxCodeObj[:externalid])
    puts "=====+++++++++++++=====+++++++++++++=====+++++++++++++= #{!taxcode.nil?}"
    if !taxcode.nil? && taxcode.update_attributes(
      :name => taxCodeObj[:name],
      :rate => taxCodeObj[:rate],
      :tax_category_id => taxCodeObj[:tax_category_id],
      :included_in_price => taxCodeObj[:included_in_price],
      :show_rate_in_label => taxCodeObj[:show_rate_in_label],
      :zone_id => taxCodeObj[:zone_id],
      :store_id => taxCodeObj[:store_id]
      )
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return {status: 'SUCCESS', message:'Taxcode Updated', data: resultTaxCode}
    else
      failedResultTaxCode = appendDataWhenTaxCodeFailed(taxCodeObj)
      # return {status: 'ERROR', message:'taxcode not updated', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data: failedResultTaxCode }
    end
  end

  def deleteTaxCode(taxCodeObj)
    # puts "deleteTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = SpreeTaxRate.find_by_id(taxCodeObj[:externalid])
    if !taxcode.nil?
      taxcode.destroy
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return {status: 'SUCCESS', message:'Taxcode Deleted', data: resultTaxCode}
    else
      failedResultTaxCode = appendDataWhenTaxCodeFailed(taxCodeObj)
      # return {status: 'ERROR', message:'taxcode not Deleted', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data: failedResultTaxCode }
    end
  end

  def appendDataInResultTaxCode(taxCodeObj, taxcode)
    resultTaxCode = taxcode.as_json
    syncdate = taxcode[:updated_at].to_s # convert date to string
    resultTaxCode[:nsid] = taxCodeObj[:nsid]
    resultTaxCode[:internalid] = taxCodeObj[:internalid]
    resultTaxCode[:status_id] = '2'
    resultTaxCode[:operation_id] = taxCodeObj[:operation_id]
    resultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
    resultTaxCode[:updated_at] = Date.parse(syncdate).strftime('%m/%d/%Y') # 07/13/2018
    
    return resultTaxCode
  end

  def appendDataWhenTaxCodeFailed(taxCodeObj)
    failedResultTaxCode = {}
    failedResultTaxCode[:nsid] = taxCodeObj[:nsid]
    failedResultTaxCode[:internalid] = taxCodeObj[:internalid]
    failedResultTaxCode[:status_id] = '3'
    failedResultTaxCode[:operation_id] = taxCodeObj[:operation_id]
    failedResultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
    
    return failedResultTaxCode
  end

end
