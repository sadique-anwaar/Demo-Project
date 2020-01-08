class CommentsController < ApplicationController

	def create
	    @product = Product.find(params[:product_id])
	    @comment = @product.comments.new(comment_params)
	    @comment.user = current_user

	    if @comment.save
	    	respond_to do |format|
	    		format.js
	    	end
	    end
 	end

 	def destroy
	    @product = Product.find(params[:product_id])
	    @comment = @product.comments.find(params[:id])
	    @comment.destroy
	    redirect_to product_path(@product)
	end

private
    def comment_params
      params.require(:comment).permit(:body)
    end

end
