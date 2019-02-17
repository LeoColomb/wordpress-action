FROM composer:1

LABEL version="1.0.0"
LABEL repository="https://github.com/LeoColomb/wordpress-action"
LABEL homepage="https://github.com/LeoColomb/wordpress-action"
LABEL maintainer="Léo Colombaro <git@colombaro.fr>"

LABEL com.github.actions.name="GitHub Action for WordPress Plugin Directory"
LABEL com.github.actions.description="Wraps the process to push a new version to the WordPress Plugin Directory."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="blue"
COPY LICENSE README.md /

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
