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
  });
});
