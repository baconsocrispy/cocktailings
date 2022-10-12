import "jquery";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log('Steps Controller Loaded')
  }

  addStep(e) {
    e.preventDefault();
    console.log('Step Prevent Default Working')
    const url = $(e.target).data('url');
    $.ajax({
      type: 'GET',
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      url: url,
      success: function(response) {
        console.log('success');
        $('#steps-list').append(response);
      }
    })
  }

  deleteStep(e) {
    e.preventDefault();
    $(e.target).closest('li').remove();
  }

  deleteStepObject(e) {
    e.preventDefault();
    const url = $(e.target).data('url')
    console.log(url)
    $(e.target).closest('li').remove()
    $.ajax({
      type: 'DELETE',
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      url: url,
      success: function(response) {
        console.log('Step Successfully Deleted')
      }
    })
  }
}