# GitHub Action for WordPress Plugin Directory

This Action for [WordPress Plugin Directory](https://wordpress.org/plugins/) enables publishing plugins for the WordPress ecosystem.

## Usage

An example workflow to publish a WordPress plugin to the WordPress Plugin Directory follows:

```hcl
workflow "Build, Test, and Publish" {
  on = "push"
  resolves = ["Publish"]
}

# Filter for a new tag
action "Tag" {
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Publish" {
  needs = "Tag"
  uses = "LeoColomb/wordpress-action@master"
  env = {
    WORDPRESS_PLUGIN = "my-awesome-plugin"
  }
  secrets = ["WORDPRESS_USERNAME", "WORDPRESS_PASSWORD"]
}
```

### Secrets

* `WORDPRESS_USERNAME` - **Required**. The username to use for authentication with the WordPress Plugin Directory. ([more info](https://developer.wordpress.org/plugins/wordpress-org/how-to-use-subversion/#your-account))
* `WORDPRESS_PASSWORD` - **Required**. The password to use for authentication with the WordPress Plugin Directory. ([more info](https://developer.wordpress.org/plugins/wordpress-org/how-to-use-subversion/#your-account))

### Environment variables

* `WORDPRESS_PLUGIN` - **Optional**. Specify the plugin name as registered on the WordPress Plugin Directory. Defaults to `reponame` in `https://github.com/org/reponame`

#### Example

To authenticate with, and publish to the WordPress Plugin Directory:

```hcl
action "Publish" {
  uses = "LeoColomb/wordpress-action@master"
  env = {
    WORDPRESS_PLUGIN = "my-awesome-plugin"
  }
  secrets = ["WORDPRESS_USERNAME", "WORDPRESS_PASSWORD"]
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

<!--Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.-->
