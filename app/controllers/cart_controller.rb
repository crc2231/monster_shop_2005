class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def add_one
    item = Item.find(params[:item_id])
    cart.add_one(item)
    redirect_to '/cart'
  end

  def remove_one
    item = Item.find(params[:item_id])
    if cart.items[item] > 1
      cart.remove_one(item)
      redirect_to '/cart'
    elsif cart.items[item] == 1
      remove_item
    end
  end

  def show
    if self.current_admin?
      render file: "/public/404"
    else
      @items = cart.contents
    end
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end


end
