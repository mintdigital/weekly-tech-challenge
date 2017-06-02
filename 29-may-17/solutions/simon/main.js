// Sub Components
Vue.component('results-display', {
  template: "#results-display",
  props: ['results']
});

// Router Components
const Search = Vue.component('github-search', {
  template: "#github-search",
  data () {
    return {
      search: '',
      results: null
    }
  },
  methods: {
    fetchData: _.debounce(function() {
      this.$http.get(
        'https://api.github.com/search/users?q=' + this.search
      ).then(response => {
        this.results = response.data;
      }, response => {
        // HACK: using the 422 response to wipe the data
        this.search = ''
        this.results = null
      });
    }, 500)
  }
});

const Profile = Vue.component('profile-display', {
  template: "#profile-display",
  data () {
    return {
      user: {}
    }
  },
  mounted () {
    this.fetchData();
  },
  methods: {
    fetchData () {
      this.$http.get(
        'https://api.github.com/users/' + this.$route.params.username
      ).then(response => {
        this.user = response.data;
      }, response => {
        console.error("Something went wrong!")
      });
    }
  }
})

// Routes
const routes = [
  { path: '/:username', component: Profile },
  { path: '/', component: Search }
]

const router = new VueRouter({
  routes: routes
})

// Instantiate Vue
const app = new Vue({
  el: "#profiler",
  router: router
})
