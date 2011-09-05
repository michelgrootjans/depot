class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @line_item }
        format.json { render json: @line_item, 
                      status: :created,
                      location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1
    if @line_item.quantity <= 0
      @line_item.destroy
    else
      @line_item.save
    end

    respond_to do |format|
      format.html { redirect_to store_path }
      format.js   { @current_item = @line_item,
                    @cart = @line_item.cart }
      format.json { head :ok }
    end
  end
end
