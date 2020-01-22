// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets

//= require_tree . 


$(document).on('click', '#validate-coupon',(event)=> {
	event.preventDefault()
	const total = $('#subtotal_amount').val()
	const code = $('#couponCode').val()
	$.ajax({type: 'GET',
			data: { total: total, couponCode: code},
		    url: '/charges/validate_coupon',
		    dataType: 'JSON',
		    success: (response) => {
		    	if (response.message == 'applied') {
		    		$('#sub_total').text(`$${response.final_amount}`)
						$('#discount_applied').text(`${response.discount}`)
						$('#final_amount').val(total)
						$('#error_msg').text(`Coupon Applied`)			
		    	}
					else
					{
						$('#error_msg').text(`Invalid Coupon`)
					}
			}

		});
});


$(document).on('change' , '.update-item-quantity', (event)=> {
	const quantity = $(event.target).val()
	const itemID = $(event.target).data('item-id')
	$.ajax({type: 'PATCH',
			data: { authenticity_token: $('[name="csrf-token"]')[0].content,
			        quantity: quantity },
			url: `/order_items/${ itemID }`,
			dataType: 'JSON',
			success: (response) =>{
				console.log(response.message)
				$(`#update-unit-total-${ itemID }`).text(`$ ${response.item_total}`)
				$('#order-subtotal').text(`$ ${response.order_total}`)
				$(event.target).val(response.quantity)
			}

	})
})