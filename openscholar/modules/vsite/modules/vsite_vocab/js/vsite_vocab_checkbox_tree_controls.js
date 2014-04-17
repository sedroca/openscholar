(function ($) {

  Drupal.behaviors.vsiteVocabExpandCollapse = {
    attach: function (context) {

      var expandButton = $(".expand-terms");
      var collapseButton = $(".collapse-terms");

      expandButton.on('click', function(){
        var controls = $(this).parent();
        var elementId = controls.attr('id');
        elementId = elementId.replace('_', '');

        // Grab the buttons of the element that match the clicked control.
        var buttons = $("#" + elementId).find('.term-reference-tree-button');
        console.log(buttons);

        buttons.each(function() {
          $(this).trigger('click');
        });
      });

      collapseButton.on('click', function(){

      });
    }
  };

})(jQuery);
