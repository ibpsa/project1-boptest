# load .env defines in root of repo
export $(egrep -v '^#' .env | xargs)
export WEB_REGISTRY_URI=boptest_service-web
export WORKER_REGISTRY_URI=boptest_service-worker
export GITHUB_ORG=ibpsa
export GITHUB_WEB_REGISTRY_URI=ghcr.io/$GITHUB_ORG/boptest-web
export GITHUB_WORKER_REGISTRY_URI=ghcr.io/$GITHUB_ORG/boptest-worker


if [[ "${GITHUB_REF}" == "refs/heads/develop" ]]; then
    export VERSION_TAG="develop"
    echo "The docker tag is set to: ${VERSION_TAG}"
elif [[ "${GITHUB_REF}" =~ ^refs/tags/v[0-9].* ]]; then
    export VERSION_TAG="${GITHUB_REF/refs\/tags\//}"
    echo "The docker tag is set to: ${VERSION_TAG}"
elif [[ "${GITHUB_REF}" == "refs/heads/experimental" ]]; then
    export VERSION_TAG="experimental"
    echo "The docker tag is set to: ${VERSION_TAG}"
fi

 if [[ "${VERSION_TAG}" == "develop" ]] || [[ "${VERSION_TAG}" =~ ^v[0-9].* ]] || [[ "${VERSION_TAG}" == "experimental" ]] ; then

    docker tag ${WEB_REGISTRY_URI}:latest ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    docker tag ${WORKER_REGISTRY_URI}:latest ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

    echo "pushing ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${GITHUB_WEB_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))
    echo "pushing ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}"
    docker push ${GITHUB_WORKER_REGISTRY_URI}:${VERSION_TAG}; (( exit_status = exit_status || $? ))

fi

exit $exit_status
