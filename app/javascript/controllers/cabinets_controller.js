import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Cabinets Controller Loaded");

    $(document).on('change', '.cabinet-select', changeLiquorCabinet);
  }
  toggleCabinetSelect(e) {
    e.preventDefault();
    $('.cabinet-select').addClass('d-block').removeClass('d-none');
  }
}

// reloads liquor cabinet display with selected liquor cabinet
function changeLiquorCabinet(e) {
  var cabinet_id = $(e.target).val();
  $.ajax({
    type: 'GET',
    dataType: 'html',
    data: { update_id: cabinet_id },
    url: $(e.target).data('url'),
    success: function (response) {
      $('.liquor-cabinet-display').html(response);
    }
  });
}