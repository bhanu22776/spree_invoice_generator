
  require 'prawn'
  require 'prawn/layout'

  @date = 

  #Logo company
  ##################################
             pdf.font "Helvetica"
             pdf.image "#{Rails.root.to_s}/app/assets/images/#{Spree::InvoiceGeneratorConfig[:print_invoice_logo_path]}" ,width:180 ,height:100

             pdf.move_up 90

  #Company Details
  ##################################
  y_position = pdf.cursor - 10
  pdf.bounding_box([300, y_position], width: 300, height: 80) do
  pdf.transparent(0.0) { pdf.stroke_bounds }
             pdf.text "Admin Off : #{Spree::CompanyConfig.company_address_number}," 
             pdf.text "#{Spree::CompanyConfig.company_street}, #{Spree::CompanyConfig.company_city} - #{Spree::CompanyConfig.company_zip}."
             pdf.text "Contact : #{Spree::CompanyConfig.company_phone}"
             pdf.text "Email : #{Spree::CompanyConfig.company_email}"
             pdf.text "Website : #{Spree::CompanyConfig.company_website}"

   pdf.move_down 10
   
             #pdf.text " VAT Number : #{Spree::CompanyConfig.company_vatnumber}"
end
             pdf.text "Purchase Proforma",size: 25  ,style: :bold ,align:  :center
             #pdf.stroke_horizontal_rule

  pdf.move_down 10

  #Company Name && Company Slogan
  ##################################

 # pdf.text "#{Spree::CompanyConfig.company_name}",style: :bold,size: 20
 # pdf.text "#{Spree::CompanyConfig.company_slogan} "

 # pdf.move_down 10

  #Company Details
  ##################################

  #y_position = pdf.cursor - 10
  #pdf.bounding_box([0, y_position], width: 250, height: 150) do
  #pdf.transparent(0.0) { pdf.stroke_bounds }
  # pdf.text "Company Address",style: :bold
  # pdf.move_down 5
  #     pdf.text "#{Spree::CompanyConfig.company_address_number}" 
  #     pdf.text "#{Spree::CompanyConfig.company_street}"
  #     pdf.text "#{Spree::CompanyConfig.company_city} - #{Spree::CompanyConfig.company_zip}        "
  #     pdf.text "Contact : #{Spree::CompanyConfig.company_phone}"
  #     pdf.text "#{Spree::CompanyConfig.company_website}  #{Spree::CompanyConfig.company_email}"
  #     pdf.text " VAT Number : #{Spree::CompanyConfig.company_vatnumber}"
  #end

  #Invoice Details
  ##################################

  #pdf.bounding_box([300, y_position], width: 250, height: 150) do
  #pdf.transparent(0.0) { pdf.stroke_bounds }
  #  pdf.text "Transaction  : #{@order.created_at.strftime("%d-%m-%Y")}", align: :right
  #  pdf.text "INVOICE NUMBER : #{(@order.number.to_s)}"  ,align: :right
  #  pdf.move_down 4

#Company Account Details
  ##################################
 
  #  pdf.text "Payment Particulars"
  # pdf.move_down 5
  #  pdf.text  "Name of the Beneficiary : #{Spree::CompanyConfig.company_beneficiary}"
  #  pdf.text "Name of the Bank : #{Spree::CompanyConfig.company_bankname}"
  #  pdf.text "Bank Branch  : #{Spree::CompanyConfig.company_branchname}"
  #  pdf.text "Bank Account Number : #{Spree::CompanyConfig.company_account_number}"
  #  pdf.text "BANK RTGS CODE :  #{Spree::CompanyConfig.company_rtgscode}"

 # end


  #Billing Address Details
  ##################################
  y_position = pdf.cursor - 10
  pdf.bounding_box([0, y_position], width: 300, height: 120) do
    pdf.transparent(0.0) { pdf.stroke_bounds }
    pdf.text "To:",size:15 , style: :bold,align: :left
    pdf.text "#{@order.bill_address.first_name}  #{@order.bill_address.lastname}"
    pdf.text "#{@order.bill_address.address1.capitalize} ,  #{@order.bill_address.address2.capitalize} ,"
    pdf.text "#{@order.bill_address.city.capitalize} - #{@order.bill_address.zipcode}"
    pdf.text "#{@order.bill_address.state}"
    pdf.text "Vat : #{@order.bill_address.vat_number}"
  end

  #Shipping Address Details
  ##################################

  pdf.bounding_box([300, y_position], width: 300, height: 120) do
    pdf.transparent(0.0) { pdf.stroke_bounds }
    pdf.text "SHIP To:",size:15 , style: :bold,align: :left
    pdf.text "#{@order.ship_address.first_name}  #{@order.ship_address.lastname}"
    pdf.text "#{@order.ship_address.address1.capitalize} ,  #{@order.ship_address.address2.capitalize} ,"
    pdf.text "#{@order.ship_address.city.capitalize} -  #{@order.ship_address.zipcode}"
    pdf.text "#{@order.ship_address.state}"
    pdf.text "Phone : #{@order.ship_address.phone}"
  end

  # Information Comments  Ends Here.
  ##################################

  #pdf.text "COMMENTS OR SPECIAL INSTRUCTIONS",style: :bold
  #pdf.text "#{@order.special_instructions.inspect}",style: :bold
  #pdf. stroke_horizontal_rule


  # Order Information // Line Items
  ##################################
  # Information Comments  Ends Here.
  ##################################
  pdf.move_down 5
  pdf.stroke_horizontal_rule

  pdf.table([ ["S.No","Description","Quantity","Unit Price","Unit Value"] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})
  @count ||= 0
  @order.line_items.each do |i|
    @quantity = i.quantity
    @name = i.variant.product.name
    @item_price = i.price
    @item_value = @quantity * @item_price
    @count += 1
    pdf.table([ ["#{@count}","#{@name}","#{@quantity}","#{@item_price}","#{@item_value}"] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})
  end

  pdf.table([ ["","","","Sub-Total","#{@order.display_item_total}".gsub(/₹/, ' ')] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})
  pdf.table([ ["","","","VAT(5%)","#{@order.tax_total}"] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})
  pdf.table([ ["","","","Shipping","#{@order.display_ship_total}".gsub(/₹/, ' ')] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})
  pdf.table([ ["","","","Total Due","#{@order.display_total}".gsub(/₹/, ' ')] ],:column_widths => [40,280,60,70,90], cell_style: {align: :center})



  @order.line_items.each do |item|
    @name = item.variant.product.name
    @item_price = number_to_currency(item.price, :unit => "")
    @quantity = item.quantity.to_s
    @total = number_to_currency(item.price * item.quantity)
    #@discount = number_to_currency(-1 * item.discount)
    #@total_discount = number_to_currency(-1 * item.discount * item.quantity)
    @name1 = item.variant.options_text.inspect
  end
    
  @order.adjustments.eligible.each do |adjustment|
    next if (adjustment.originator_type == 'Spree::TaxRate') and (adjustment.amount == 0)
    next if (adjustment.amount == 0)
    @product_adjustment_label =  adjustment.label
    @product_adjustment = number_to_currency adjustment.amount
  end

    @subtotal =

  # LIne Items / Order Data in Table
  ##################################

  # RTGS DETAILS
  ########################
   
    pdf.move_down 10
    pdf.text "OUR RTGS DETAILS:", style: :bold,size:15
    pdf.move_down 5
    pdf.text  "NAME : #{Spree::CompanyConfig.company_beneficiary}" 
    pdf.move_down 5 
    pdf.text "BANK NAME : #{Spree::CompanyConfig.company_bankname}"
    pdf.move_down 5
    pdf.text "BRANCH : #{Spree::CompanyConfig.company_branchname}"
    pdf.move_down 5
    pdf.text "ACCOUNT NUMBER : #{Spree::CompanyConfig.company_account_number}"
    pdf.move_down 5
    pdf.text "RTGS CODE :  #{Spree::CompanyConfig.company_rtgscode}"

  #  Footer
  ##############################################


    pdf.move_down 30

    pdf.text "Thanking You,"
    pdf.move_down 5
    pdf.text "Yours Faithfully,"
    pdf.move_down 5
    pdf.text "For SALASAR INDUSTRIES INDIA LIMITED"
    
    pdf.move_down 30

    #pdf.move_cursor_to 45
    
    pdf.text "* This is a Computarized Generated proforma & requires no Signature"
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "Payment made beyond due date shall be charged interest @ 24% per annum "
    #pdf.text "Contact :: #{Spree::CompanyConfig.company_name},#{Spree::CompanyConfig.company_phone} or #{Spree::CompanyConfig.company_email}",style: :bold

  #  PDF ENDS HERE
  ##############################################
