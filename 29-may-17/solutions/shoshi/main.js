var App = window.App || {};

Vue.component('github-users', {
  template: '#github-users-template',
  data: function() {
    return {
      query: '',
      results: null
    }
  },

  methods: {
    fetchData: function() {
      var xhr = new XMLHttpRequest(),
         self = this;
      if ( self.query.length > 0 ) {
        xhr.open('GET', 'https://api.github.com/search/users?q=' + self.query);
        xhr.onload = function() {
          self.results = JSON.parse(xhr.responseText);
        }
        xhr.send();
      }
    }
  }
});

App = new Vue({
  el: '#app'
})
