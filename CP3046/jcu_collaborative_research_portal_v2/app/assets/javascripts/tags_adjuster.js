$(document).ready(function() {
  $(function() {

    // Find all the markdown textareas
    $('.tag_form').each( function() {
      $(this).bind("ajax:success", function(xhr, data, status) {
        // On success, modify the class of the inputs
        $(this).addClass("current").removeClass("not_current");
        $(this).siblings(".tag_form").addClass("not_current").removeClass("current");

        console.log(xhr);
        console.log(data);
        console.log(status);
      });


      $(this).bind("ajax:error", function(xhr, status, error) {
        console.log("Error in tag adjuster ajax call.");
        console.log(xhr);
        console.log(status);
        console.log(error);
      });

    });

  });
});
