Vue.component('user-profile', {
  props: ['selectedUser', 'users'],
  template: '<div>User: {{ selectedUser }} <img :src="profilePic" ></div>',
  computed: {
    profilePic: function() {
      var selectedUser = this.selectedUser;
      return this.users.find(function(user) {
        return user.login === selectedUser;
      }).avatar_url;
    }
  }
});
Vue.component('github-search', {
  template: '#github-search-template',
  data: function() {
    return {
      users: [],
      searchTerm: null,
      selectedUser: ''
    }
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
    }
  }
});

var app = new Vue({
  el: '#github-profiler'
});
