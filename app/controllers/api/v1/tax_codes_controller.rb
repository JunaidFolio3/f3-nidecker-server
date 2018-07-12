class Api::V1::TaxCodesController < ApplicationController

  def getTaxCode
    render json: {status: 'SUCCESS', message:'Loaded tax codes', data:'taxCodesObj'},status: :ok
  end
  
  def executeDBOperationForTaxCode
    taxCodesData = params[:_json]
    taxCodeResponses = Array.new()

    i = 0
    # puts "request body: #{taxCodesData}"
    while i < taxCodesData.length  do
      # puts "=====+++++++++++++#{i}=====+++++++++++++#{taxCodesData[i][:operation_id] == '1' } #{taxCodesData[i][:operation_id]}"

    #   if taxCodesData[i][:operation_id] == '1' 
    #     # puts "=====+++++++++++++createTaxCode=====+++++++++++++"
    #     createTaxCode(taxCodesData[i])
    #   elsif taxCodesData[i][:operation_id] == '2'
    #     # puts "=====+++++++++++++updateTaxCode=====+++++++++++++"
    #     updateTaxCode(taxCodesData[i])
    #   elsif taxCodesData[i][:operation_id] == '3' 
    #     # puts "=====+++++++++++++deleteTaxCode=====+++++++++++++"
    #     deleteTaxCode(taxCodesData[i])
    #   end
    #   # createUpdateTaxCodes(taxCodesArr[i][:internalid], taxCodesArr[i][:name], taxCodesArr[i][:rate])
    #   i +=1
    # end

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
    # createOrUpdateTaxCodes()
    # create()
  end

  def createTaxCode(taxCodeObj)
    # puts "createTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = TaxCode.new( 
      :name => taxCodeObj[:name],
      :rate => taxCodeObj[:rate]
      )
     
    if taxcode.save
      # repeated code ===========
      resultTaxCode = taxcode.as_json
      resultTaxCode[:nsid] = taxCodeObj[:nsid]
      resultTaxCode[:status_id] = '2'
      resultTaxCode[:operation_id] = taxCodeObj[:operation_id]
      resultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
      # =========================
      return  {status: 'SUCCESS', message:'Taxcode created', data:resultTaxCode}
    else
      return  {status: 'ERROR', message:'Taxcode not created', data:taxcode.errors},status: :unprocessable_entity
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
      # repeated code ===========
      resultTaxCode = taxcode.as_json
      resultTaxCode[:nsid] = taxCodeObj[:nsid]
      resultTaxCode[:status_id] = '2'
      resultTaxCode[:operation_id] = taxCodeObj[:operation_id]
      resultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
      # =========================
      return {status: 'SUCCESS', message:'Taxcode Updated', data:resultTaxCode}
    else
      # return {status: 'ERROR', message:'taxcode not updated', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data:[]}
    end
  end

  def deleteTaxCode(taxCodeObj)
    puts "deleteTaxCode:taxCodeObj: #{taxCodeObj}"
    taxcode = TaxCode.find_by_id(taxCodeObj[:externalid])
    if !taxcode.nil?
      taxcode.destroy
      # repeated code ===========
      resultTaxCode = taxcode.as_json
      resultTaxCode[:nsid] = taxCodeObj[:nsid]
      resultTaxCode[:status_id] = '2'
      resultTaxCode[:operation_id] = taxCodeObj[:operation_id]
      resultTaxCode[:recordtype_id] = taxCodeObj[:recordtype_id]
      # =========================
      return {status: 'SUCCESS', message:'Taxcode Deleted', data:resultTaxCode}
    else
      # return {status: 'ERROR', message:'taxcode not Deleted', data:'taxcode.errors'},status: :unprocessable_entity
      return {status: 'ERROR', message:'taxcode not exist', data:[]}
    end
  end


  # def createOrUpdateTaxCodes
  #   i = 0
  #   taxCodesArr = params[:_json]
  #   # taxCodesArr = params
  #   puts "request body length: #{taxCodesArr.length}"
  #   puts "request body taxCodesArr: #{taxCodesArr}"
  #   while i < taxCodesArr.length  do
  #      createUpdateTaxCodes(taxCodesArr[i][:internalid], taxCodesArr[i][:name], taxCodesArr[i][:rate])
  #      i +=1
  #   end

  #   render json: {status: 'SUCCESS', body:true, data:taxCodesArr, count: taxCodesArr.length},status: :ok
  # end

  # def createUpdateTaxCodes(internalid, name, rate)
  #     @tax = TaxCode.find_by_internalid(internalid) || TaxCode.new(:internalid => internalid)
  #     @tax.update_attributes(
  #             :name => name,
  #             :rate => rate
  #         )
  # end

  # def create
  #   # taxCodesArr = params[:_json]
  #   # puts "request taxcode_params: #{taxCodesArr}"
  #   taxcode = TaxCode.new(taxcode_params)
     

  #   if taxcode.save
  #     render json: {status: 'SUCCESS', message:'Saved taxcode', data:taxcode},status: :ok
  #   else
  #     render json: {status: 'ERROR', message:'taxcode not saved', data:taxcode.errors},status: :unprocessable_entity
  #   end
  # end

  # private

  # def taxcode_params
  #   params.permit(:name, :rate)
  # end

  # def update
  #   taxcode = taxcode.find(params[:id])
  #   if taxcode.update_attributes(taxcode_params)
  #     render json: {status: 'SUCCESS', message:'Updated taxcode', data:taxcode},status: :ok
  #   else
  #     render json: {status: 'ERROR', message:'taxcode not updated', data:taxcode.errors},status: :unprocessable_entity
  #   end
  # end

end
