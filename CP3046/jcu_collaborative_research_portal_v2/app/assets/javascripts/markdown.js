$(document).ready(function() {
  $(function() {

    // Throttle function used to reduce ajax on_change callbacks 
    // Note: throttle function from: http://remysharp.com/2010/07/21/throttling-function-calls/ 
    function throttle(f, delay){
      var timer = null;
      return function(){
        var context = this, args = arguments;
        clearTimeout(timer);
        timer = window.setTimeout(
          function(){ f.apply(context, args); }, 
          delay || 500   // default the delay to half-a-second
        );
      };
    }

    // Find all the markdown textareas
    $('.markdown_input').each( function(i) {
      var text_area = this;
      $('<div class="ui-widget ui-widget-content markdown_preview"></div>').hide().insertAfter(text_area);

      // Watch for keypress events in the textarea (throttle the call-back)
      $(this).keypress(throttle(function() {
        // On key press, send the markdown content to the ajax markdown processor
        // Returns the markdown content as html
        $.ajax({
          type: "POST",
          url: markdown_preview_url,
          dataType: "html",
          data: { text: $(text_area).val() },
          success: function(obj) {
            // On success,
            // Find the preview area for the markdown textarea, and change its html
            // to be the output of the markdown process
            // Also, highlight the area, to let the user know that it has changed.
            $(text_area).siblings('.markdown_preview').html("<p class='ui-widget-shadow markdown_preview_prompt'>Preview</p>" + obj).effect("highlight");
          },
          error: function() {
            // On error,
            // Find the preview area for the markdown textarea, and change its html
            // to be a nice error message explaining that the preview couldn't be generated
            $(text_area).siblings('.markdown_preview').html("<div class='system_message'><p class='error ui-state-error'>Failed to generate preview</p></div>").effect("highlight");
          }
        })
      }));
    });
  });
});
