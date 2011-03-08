// Originally from redcloth.org

TryRedClothObserver = Class.create({
  initialize: function(observable, htmlResultElement, postUrl) {
    this.observable = $(observable);
    this.htmlResultElement = $(htmlResultElement);
    this.postUrl= postUrl;
    this.initObserver();
  },
  initObserver: function() {
    new Form.Element.Observer(
      this.observable,
      5,  // 5 seconds
      this.parseRedcloth.bind(this)
    );
  },
  parseRedcloth: function(event) {
    var rcObserver = this;
    var request_url = rcObserver.postUrl;
    new Ajax.Request(request_url, {
	  method: 'post',
      parameters: { text: rcObserver.observable.value },
      onSuccess: function(response) {
          rcObserver.htmlResultElement.update(response.responseText);
      }
    });
  }
});
