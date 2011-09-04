class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = LineItem.find(params[:id])
    if @item.quantity <= 1
      @item.destroy
    else
      @item.quantity -= 1
      @item.save
    end

    respond_to do |format|
      format.html { redirect_to store_path }
      format.js   { @current_item = @item, @cart = @item.cart }
      format.json { head :ok }
    end
  end
end
