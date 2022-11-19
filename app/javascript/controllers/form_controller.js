import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    $('#add-image-btn').on('change', ({ target }) => {
      if (target.files && target.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
          $('#image-preview')
            .attr('src', e.target.result)
            .width(150);
        };

        reader.readAsDataURL(target.files[0]);

        $('#image-preview').attr('data-image', true);
        $('.add-image-label').html('Edit Image');
      }
    });

    $('#recipe_name').on('keyup', ({ target }) => {
      $('.form-header').html(target.value);
      if (target.value == '') $('.form-header').html('New Recipe');
    });
  }

  deleteRecipe(e) {
    console.log('work');
    e.preventDefault();
  }
}