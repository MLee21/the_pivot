$(document).ready(function(){

  var $items = $('.hotdog_item')

  $('#category_id').on('change', function () {
    var currentCategory = $('#category_id').val();      
    $items.each(function (index, item) {
      $item = $(item);
      if (check(currentCategory, $item.data('categories'))) {
        $item.show();
      } else {
        $item.hide();
      }
    });
  });

  function check(name, array) {
    for (i = 0; i < array.length; i++) {
      if (array[i] === name) {
        return true
      }
    }
    return false
  }

});