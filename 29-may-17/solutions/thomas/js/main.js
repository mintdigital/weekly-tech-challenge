var app = new Vue({
  el: '#github-profiler',
  data: {
    users: [],
    username: null,
    selectedUser: ''
  },
  methods: {
    searchUsers: function(ev) {
      this.username = ev.target.value;

      axios.get('https://api.github.com/search/users?q=' + this.username).then(function(resp) {
        this.users = resp.data.items;
      }.bind(this));
    },
    profilePic: function(username) {
      return this.users.find(function(user) {
        return user.login === username;
      }).avatar_url;
    }
  }
});
