// From redcloth.org

TryRedClothObserver = Class.create({
  initialize: function(observable, resultElement, htmlResultElement, postUrl) {
    this.observable = $(observable);
  //  this.resultElement = $(resultElement);
    this.htmlResultElement = $(htmlResultElement);
    this.postUrl= postUrl;
    this.initObserver();
  },
  initObserver: function() {
    new Form.Element.Observer(
      this.observable,
      0.2,  // 200 milliseconds
      this.parseRedcloth.bind(this)
    );
  },
  parseRedcloth: function(event) {
    var rcObserver = this;
    var request_url = rcObserver.postUrl;
    new Ajax.Request(request_url, {
	  method: 'get',
      parameters: { previewtext: rcObserver.observable.value },
      onSuccess: function(response) {
//        rcObserver.resultElement.update(response.responseText);
//        rcObserver.htmlResultElement.update(response.responseText.escapeHTML());
          rcObserver.htmlResultElement.update(response.responseText);
      }
    });
  }
});
