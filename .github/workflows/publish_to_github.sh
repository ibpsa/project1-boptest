# load .env defines in root of repo 
export $(egrep -v '^#' .env | xargs)
export GITHUB_WEB_REGISTRY_URI=ghcr.io/tijcolem/boptest-web
export GITHUB_WORKER_REGISTRY_URI=ghcr.io/tijcolem/boptest-worker

if [[ "${GITHUB_REF}" == "refs/heads/boptest-service" ]]; then
    export VERSION_TAG="develop"
    echo "The docker tag is set to: ${VERSION_TAG}"
elif [[ "${GITHUB_REF}" =~ ^refs/tags/v[0-9].*-service ]]; then
    export VERSION_TAG="${GITHUB_REF/refs\/tags\//}"
    echo "The docker tag is set to: ${VERSION_TAG}"
# use conditional below if you want to build a custom branch
# elif [[] "${GITHUB_REF}" == "refs/heads/boptest-service-custom" ]]; then 
#     export VERSION_TAG="experimental"
fi

 if [[ "${VERSION_TAG}" == "develop" ]] || [[ "${VERSION_TAG}" =~ ^v[0-9].*-service ]] || [[ "${VERSION_TAG}" == "experimental" ]] ; then

    docker tag ${WEB_REGISTRY_URI}:latest ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    docker tag ${WORKER_REGISTRY_URI}:latest ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

    echo "pushing ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    echo "pushing ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

fi

exit $exit_status
