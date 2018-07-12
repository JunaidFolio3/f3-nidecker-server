class Api::V1::TaxCodesController < ApplicationController

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
    taxcode = TaxCode.new( 
      :name => taxCodeObj[:name],
      :rate => taxCodeObj[:rate]
      )
     
    if taxcode.save
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return  {status: 'SUCCESS', message:'Taxcode created', data:resultTaxCode}
    else
      # return  {status: 'ERROR', message:'Taxcode not created', data:taxcode.errors},status: :unprocessable_entity
      return  {status: 'ERROR', message:'Taxcode not created', data:[]}
    end
  end

  def updateTaxCode(taxCodeObj)
    # puts "updateTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = TaxCode.find_by_id(taxCodeObj[:externalid])
    puts "=====+++++++++++++=====+++++++++++++=====+++++++++++++= #{!taxcode.nil?}"
    if !taxcode.nil? && taxcode.update_attributes(
        :name => taxCodeObj[:name],
        :rate => taxCodeObj[:rate]
      )
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return {status: 'SUCCESS', message:'Taxcode Updated', data:resultTaxCode}
    else
      # return {status: 'ERROR', message:'taxcode not updated', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data:[]}
    end
  end

  def deleteTaxCode(taxCodeObj)
    # puts "deleteTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = TaxCode.find_by_id(taxCodeObj[:externalid])
    if !taxcode.nil?
      taxcode.destroy
      resultTaxCode = appendDataInResultTaxCode(taxCodeObj, taxcode)
      return {status: 'SUCCESS', message:'Taxcode Deleted', data:resultTaxCode}
    else
      # return {status: 'ERROR', message:'taxcode not Deleted', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data:[]}
    end
  end

  def appendDataInResultTaxCode(taxCodeObj, taxcode)
    resultTaxCode = taxcode.as_json
    resultTaxCode[:nsid] = taxCodeObj[:nsid]
    resultTaxCode[:status_id] = '2'
    resultTaxCode[:operation_id] = taxCodeObj[:operation_id]
    resultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
    return resultTaxCode
  end

end
