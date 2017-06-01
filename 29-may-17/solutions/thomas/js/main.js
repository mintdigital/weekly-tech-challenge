var app = new Vue({
  el: '#github-profiler',
  data: {
    users: [],
    searchTerm: null,
    selectedUser: ''
  },
  methods: {
    searchUsers: function(ev) {
      this.selectedUser = '';
      this.searchTerm = ev.target.value;

      var xhr = new XMLHttpRequest(),
          self = this;
      xhr.open('GET', 'https://api.github.com/search/users?q=' + this.searchTerm);
      xhr.onload = function() {
        var data = JSON.parse(xhr.responseText);
        self.users = data.items;
      };
      xhr.send();
    },
    profilePic: function(username) {
      return this.users.find(function(user) {
        return user.login === username;
      }).avatar_url;
    }
  }
});
