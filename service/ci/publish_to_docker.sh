# load .env defines in root of repo
export $(egrep -v '^#' .env | xargs)
export DOCKER_HUB_WEB_REGISTRY_URI=NREL/boptest-web
export DOCKER_HUB_WORKER_REGISTRY_URI=NREL/boptest-worker

if [[ "${GITHUB_REF}" == "refs/heads/develop" ]]; then
    export VERSION_TAG="develop"
    echo "The docker tag is set to: ${VERSION_TAG}"
elif [[ "${GITHUB_REF}" =~ ^refs/tags/v[0-9].* ]]; then
    export VERSION_TAG="${GITHUB_REF/refs\/tags\//}"
    echo "The docker tag is set to: ${VERSION_TAG}"
# uncomment conditional below if you want to build a custom branch
# elif [[] "${GITHUB_REF}" == "refs/heads/boptest-service-custom" ]]; then
#     export VERSION_TAG="experimental"
fi

 if [[ "${VERSION_TAG}" == "develop" ]] || [[ "${VERSION_TAG}" =~ ^v[0-9].* ]] || [[ "${VERSION_TAG}" == "experimental" ]] ; then

    docker tag ${WEB_REGISTRY_URI}:latest ${DOCKER_HUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    docker tag ${WORKER_REGISTRY_URI}:latest ${DOCKER_HUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

    echo "pushing ${DOCKER_HUB_WEB_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${DOCKER_HUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    echo "pushing ${DOCKER_HUB_WORKER_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${DOCKER_HUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

fi

exit $exit_status
